class Consumer

 attr_reader :id
 attr_accessor :exp

 @@id_set = []
 MAX_NUMBER_OF_CONSUMERS = 50

 def initialize(id, exp)
  if @@id_set.include? id
   raise Exception.new('Duplicate Consumer Id')
  elsif @@id_set.size == MAX_NUMBER_OF_CONSUMERS
   raise Exception.new('Maximum Consumers Limit Reached')
  end
  @id = id
  @exp = exp
  @@id_set.push(id)
 end

 def consume(msg)
  status = true
  begin
   unless msg.scan(Regexp.new(@exp)).empty?
    puts "Consumer #{@id} consumes #{msg}"
    sleep(1)
   end
  rescue Exception => e
   status = false
  end
  status
 end

end
