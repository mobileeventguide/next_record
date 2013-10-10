# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'next_record/version'

Gem::Specification.new do |spec|
  spec.name          = "next_record"
  spec.version       = NextRecord::VERSION
  spec.authors       = ["Helge Rausch"]
  spec.email         = ["helge@rausch.io"]
  spec.description   = %q{adds `next` and `previous` methods to your records}
  spec.summary       = %q{adds `next` and `previous` methods to your records}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
