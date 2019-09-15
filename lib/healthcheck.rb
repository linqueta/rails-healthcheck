# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'
require 'healthcheck/check'

module Healthcheck
  Configuration::SETTINGS.each do |setting|
    send(:define_method, setting, -> { config.send(setting) })
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
