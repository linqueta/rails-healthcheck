# frozen_string_literal: true

module Healthcheck
  class Checker
    attr_accessor :errors

    def initialize
      @errors = []
    end

    def check
      Healthcheck.configuration.checks.map { |c| Thread.new { execute(c) } }.each(&:join)
    end

    def errored?
      @errors.any?
    end

    private

    def execute(check)
      check.execute!
    rescue StandardError => e
      @errors << Error.new(check.name, e.class, e.message)
    end
  end
end
