# frozen_string_literal: true

require 'action_controller/railtie'
module Healthcheck
  class HealthchecksController < ActionController::Base
    def check
      execute
      errored? ? error : success
    end

    private

    def execute
      checker.check
    end

    def errored?
      checker.errored?
    end

    def checker
      @checker ||= Healthcheck::Checker.new
    end

    def success
      head Healthcheck.configuration.success
    end

    def error
      return head(Healthcheck.configuration.error) unless Healthcheck.configuration.verbose

      render json: {
        code: Healthcheck.configuration.error,
        errors: checker.errors.as_json
      },
             status: Healthcheck.configuration.error
    end
  end
end
