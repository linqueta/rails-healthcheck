# frozen_string_literal: true

require 'bundler/setup'
require 'support/configs/simple_cov_config'
SimpleCovConfig.configure

require 'healthcheck'
require './app/controllers/healthcheck_controller'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) { Healthcheck.configuration.clear! }
end
