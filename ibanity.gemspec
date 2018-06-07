# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ibanity/version'

Gem::Specification.new do |spec|
  spec.name          = "ibanity"
  spec.version       = Ibanity::VERSION.dup
  spec.authors       = ["Ibanity"]
  spec.email         = ["info@ibanity.com"]
  spec.summary       = "Ibanity Ruby Client"
  spec.description   = "A Ruby wrapper for the Ibanity API."
  spec.homepage      = "https://documentation.ibanity.com/api/ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", ">= 1.8.0"
  spec.add_development_dependency "rspec", "3.4.0"
  spec.add_development_dependency "webmock", "1.24.2"
end
