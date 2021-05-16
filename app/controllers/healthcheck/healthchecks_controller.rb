# frozen_string_literal: true

require 'action_controller/railtie'

module Healthcheck
  class HealthchecksController < ActionController::Base
    def check
      return Healthcheck.custom!(self) if Healthcheck.custom?

      checker = Healthcheck.check
      response = if checker.errored?
                   Healthcheck::Response::Error.new(self, checker)
                 else
                   Healthcheck::Response::Success.new(self, checker)
                 end
      response.execute!
    end
  end
end
