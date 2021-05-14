# frozen_string_literal: true

module Healthcheck
  module Response
    class Success < Base
      def verbose
        {
          status: @configuration.success,
          json: {
            code: @configuration.success,
            status: @configuration.checks.each_with_object({}) { |check, obj| obj[check.name] = 'OK' }
          }
        }
      end

      def status
        @configuration.success
      end
    end
  end
end
