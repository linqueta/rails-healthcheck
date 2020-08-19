# frozen_string_literal: true

require 'action_controller/railtie'
module Healthcheck
  class HealthchecksController < ActionController::Base
    def check
      checker = Healthcheck.check
      return Healthcheck.configuration.custom.call(self, checker) if Healthcheck.configuration.custom
      return head Healthcheck.configuration.success unless checker.errored?

      verbose? ? verbose_error(checker) : head_error
    end

    private

    def head_error
      head Healthcheck.configuration.error
    end

    def verbose_error(checker)
      render status: Healthcheck.configuration.error,
             json: {
               code: Healthcheck.configuration.error,
               errors: checker.errors.as_json
             }
    end

    def verbose?
      Healthcheck.configuration.verbose
    end
  end
end
