# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redmind/version'

Gem::Specification.new do |spec|
  spec.name          = "redmind"
  spec.version       = Redmind::VERSION
  spec.authors       = ["kkosman"]
  spec.email         = ["krzysztof.kosman@gmail.com"]
  spec.description   = "Redmine command line tool"
  spec.summary       = "Simple command line tool to control some of Redmine users activities."
  spec.homepage      = "http://1000i.pl"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["redmind"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
