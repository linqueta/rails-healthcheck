# frozen_string_literal: true

module Healthcheck
  module Response
    class Error < Base
      def verbose
        {
          status: Healthcheck.configuration.error,
          json: {
            code: Healthcheck.configuration.error,
            errors: @checker.errors.as_json
          }
        }
      end

      def status
        @configuration.error
      end
    end
  end
end
