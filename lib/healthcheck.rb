# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'

module Healthcheck
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
