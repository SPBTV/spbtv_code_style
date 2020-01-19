# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spbtv_code_style'

Gem::Specification.new do |spec|
  spec.name          = 'spbtv_code_style'
  spec.version       = SpbtvCodeStyle::VERSION
  spec.authors       = ['Team Web Dev']
  spec.email         = ['teammiddleware@spbtv.com']

  spec.summary       = 'SpbTV code style'
  spec.homepage      = 'https://github.com/spbtv/spbtv_code_style'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rspec_junit_formatter'
  spec.add_runtime_dependency 'rubocop-checkstyle_formatter'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.75'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36'
end
