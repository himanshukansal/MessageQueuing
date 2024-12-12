require 'consumer'
require 'util'
require 'filewatcher'
require 'message_test'
require 'thread'

class Message

 MAX_RETRIES = 3
 attr_accessor :g, :qu, :max_queue_size

 class Graph
  attr_reader :nodes
  attr_accessor :visited, :stack

  def initialize
   @nodes = Array.new
   @visited = []
   @stack = []
  end

  def add(parent_node, node)
   unless @nodes[parent_node.id]
    @nodes[parent_node.id] = [ [], [] ]
    @nodes[parent_node.id][0].push(parent_node)
   end
   @nodes[parent_node.id][1].push(node)
  end

 end

 def initialize
  @g = Graph.new
  @qu = Queue.new
  @max_queue_size = 100
  @mutex = Mutex.new
  @condition = ConditionVariable.new
 end

 def register_consumer(consumer, dependencies)
  node.new(consumer, dependencies)
  g.add(consumer)
 end

 def start_producer(file_path, size=100)
  @max_queue_size = size
  Thread.start { produce(file_path) }
 end

 def produce(file_path)
  Filewatcher.new([file_path]).watch do |file_event|
    file_event.each do |filename, event|
      if(event == :updated)
        msgs = IO.readlines(file_path)
        msgs.each do |msg|
          @mutex.synchronize do
            while @qu.size >= @max_queue_size
              puts 'Queue is full, waiting...'
              @condition.wait(@mutex)
            end

            @qu.push(msg)
            puts "Message added to queue: #{msg.chomp}"
            @condition.signal
          end
        end
      end
    end
  end
 end

 def consume_message_util(v)
  @g.visited[v.id] = true
  unless Util.empty(@g.nodes[v.id]) || Util.empty(@g.nodes[v.id][1])
   @g.nodes[v.id][1].each do |node|
    unless @g.visited[node.id] == true
     consume_message_util node
    end
   end
  end
  @g.stack.push(v)
 end

 def consume_message
  while(true)
    @mutex.synchronize do
     while @qu.empty?
       puts "Queue is empty, waiting..."
       @condition.wait(@mutex)
     end
    end

    msg = @qu.shift
    puts "Message dequeued: #{msg.chomp}"
    @condition.signal

    @g.visited = []
    @g.nodes.each do |arr|
     unless Util.empty(arr) || Util.empty(arr[0]) || @g.visited[arr[0][0].id]
      consume_message_util arr[0][0]
     end
    end
    while !@g.stack.empty?
     consumer_obj = @g.stack.pop()
     status = consumer_obj.consume(msg)
     count = 1
     while count < MAX_RETRIES && status == false
      status = consumer_obj.consume(msg)
      count+=1
     end
    end
  end
 end


end
