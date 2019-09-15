# frozen_string_literal: true

require 'action_controller/railtie'

class HealthcheckController < ActionController::Base
  def check
    head checker.check!.code
  end

  private

  def checker
    @checker ||= Healthcheck::Checker.new
  end

  # def error(_exception)
  #   Healthcheck.verbose ? head : verbose
  # end

  # def head
  #   head Healthcheck.error
  # end

  # def verbose
  #   render json: {}, status: Healthcheck.error
  # end
end
