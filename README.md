# Message

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem.

## Installation
Install Ruby >= 2.2.2
**https://www.ruby-lang.org/en/documentation/installation/**

Mac OSX:

`$ brew install ruby`

And then execute (in root directory of repository):

    gem install filewatcher
    gem build Message.gemspec
    gem install Message-1.0.gem


## Run

Launch Ruby Interpreter:
 
 `irb`
 
And execute:

`> require 'message'`

`> obj = MessageTest.new`

`> obj.start`

 

## Testing
**Modify lib/message_test.rb**

**Reinstall Gem**

    gem uninstall Message-1.0.gem
    gem build Message.gemspec
    gem install Message-1.0.gem
    
**Run Again**

## License


