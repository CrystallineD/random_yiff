# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'random_yiff/version'

Gem::Specification.new do |spec|
  spec.name          = 'random_yiff'
  spec.version       = RandomYiff::VERSION
  spec.authors       = ['James Awesome']
  spec.email         = ['james@wesome.nyc']
  spec.summary       = 'Get random furry pr0n from e621.net'
  spec.homepage      = 'https://github.com/jamesawesome/random_yiff'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'webmock', '~> 1.20'
end
