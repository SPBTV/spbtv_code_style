lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spbtv_code_style'

Gem::Specification.new do |spec|
  spec.name          = 'spbtv_code_style'
  spec.version       = SpbtvCodeStyle::VERSION
  spec.authors       = ['Tema Bolshakov']
  spec.email         = ['abolshakov@spbtv.com']

  spec.summary       = 'SpbTV code style'
  spec.homepage      = 'https://github.com/spbtv/spbtv_code_style'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rspec_junit_formatter'
  spec.add_runtime_dependency 'rubocop-checkstyle_formatter'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
end
