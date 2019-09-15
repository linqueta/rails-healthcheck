# frozen_string_literal: true

require 'action_controller/railtie'

class HealthcheckController < ActionController::Base
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
    head Healthcheck.success
  end

  def error
    head Healthcheck.error unless Healthcheck.verbose

    render json: { code: Healthcheck.error, errors: checker.errors.as_json }, status: Healthcheck.error
  end
end
