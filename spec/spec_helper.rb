# frozen_string_literal: true

require 'bundler/setup'
require 'support/configs/simple_cov_config'
SimpleCovConfig.configure

require 'healthcheck'
require './app/controllers/healthcheck/healthchecks_controller'

require File.expand_path('../spec/dummy/config/environment.rb', __dir__)
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '../../../spec/dummy'

require 'rspec/rails'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before { Healthcheck.configuration.clear! }
end
