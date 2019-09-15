# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'
require 'healthcheck/check'
require 'healthcheck/checker'

module Healthcheck
  Configuration::SETTINGS.each do |setting|
    send(:define_singleton_method, setting, -> { configuration.send(setting) })
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
