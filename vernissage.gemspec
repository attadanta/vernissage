# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vernissage/version'

Gem::Specification.new do |spec|
  spec.name = "vernissage"
  spec.version = Vernissage::Version.to_s
  spec.authors = ["Kiril Tonev"]
  spec.email = ["kiril.tonev@gmail.com"]
  spec.description = %q{A web gallery processor made for http://plamenmadjarovart.com}
  spec.summary = %q{A web gallery processor made for http://plamenmadjarovart.com}
  spec.homepage = "http://mischung.net"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "haml"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "rdiscount"
end
