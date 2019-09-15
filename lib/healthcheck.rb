# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'
require 'healthcheck/check'

module Healthcheck
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
