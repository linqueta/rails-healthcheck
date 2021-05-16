# frozen_string_literal: true

require 'healthcheck/version'
require 'healthcheck/configuration'
require 'healthcheck/check'
require 'healthcheck/checker'
require 'healthcheck/error'
require 'healthcheck/router'
require 'healthcheck/engine'

require 'healthcheck/response/base'
require 'healthcheck/response/success'
require 'healthcheck/response/error'

module Healthcheck
  CONTROLLER_ACTION = 'Healthcheck::HealthchecksController#check'

  module_function

  def configure
    yield(configuration)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  def routes(router)
    Router.mount(router)
  end

  def check
    Checker.new.tap(&:check)
  end

  def custom!(controller)
    configuration.custom.call(controller, check)
  end

  def custom?
    configuration.custom
  end
end
