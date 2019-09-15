# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'

module SimpleCovConfig
  def self.configure
    SimpleCov.formatter = SimpleCov::Formatter::Console
    SimpleCov.minimum_coverage 100
    SimpleCov.start
  end
end
