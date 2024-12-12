# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative 'lib/Message/version'

Gem::Specification.new do |spec|
  spec.name          = "Message"
  spec.version       = Message::VERSION
  spec.authors       = ["himanshukansal"]
  spec.email         = ["himanshukansal02@gmail.com"]

  spec.summary       = %q{A lightweight message queuing system.}
  spec.description   = %q{Message is a simple and efficient message queuing gem for handling asynchronous tasks.}
  spec.homepage      = 'https://github.com/himanshukansal/MessageQueuing'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.include?('Message-1.0.gem') }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest"
end
