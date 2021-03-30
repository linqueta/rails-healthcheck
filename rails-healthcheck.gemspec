# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'healthcheck/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails-healthcheck'
  spec.version       = Healthcheck::VERSION
  spec.authors       = ['linqueta']
  spec.email         = ['lincolnrodrs@gmail.com']

  spec.summary       = 'Healthcheck route for a Rails application'
  spec.description   = 'A simple way to configure a healthcheck route for a Rails application'
  spec.homepage      = 'https://github.com/linqueta/rails-healthcheck'
  spec.license       = 'MIT'

  spec.files         = Dir['{app}/**/*', '{lib}/**/*', 'README.md']

  spec.required_ruby_version = '>= 2.5.1'

  spec.add_dependency 'actionpack'
  spec.add_dependency 'railties'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop', '>= 0.74.0'
  spec.add_development_dependency 'rubocop-performance', '>= 1.4.1'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'simplecov-console', '>= 0.5.0'
  spec.add_development_dependency 'timecop'
end
