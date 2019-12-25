# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'
require 'healthcheck/check'
require 'healthcheck/checker'
require 'healthcheck/error'
require 'healthcheck/router'
require 'healthcheck/engine'

module Healthcheck
  module_function

  def configure
    yield(configuration)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  def routes(router)
    Healthcheck::Router.mount(router)
  end
end
