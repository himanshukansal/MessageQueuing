require 'message'

class MessageTest

 def start
  # Consumer constructor takes two parameter - Unique Consumer Id, Regexp for messages to be consumed
  obj = Consumer.new(1, '.*')
  obj2 = Consumer.new(2, '.*')
  obj3 = Consumer.new(3, '.*')

  m = Message.new

  #To create dependencies between different consumers in DAG
  # Example A->B (m.g.add(A, B)). A will consume before B
  m.g.add(obj2, obj)
  m.g.add(obj3, obj)

  #start_producer takes one argument i.e. file path from which producer will read
  m.start_producer('/Users/himanshu/Desktop/test.txt')

  #Starts Consumers
  m.consume_message
 end

end
