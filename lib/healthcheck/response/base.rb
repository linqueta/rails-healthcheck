# frozen_string_literal: true

module Healthcheck
  module Response
    class Base
      def initialize(controller, checker)
        @controller = controller
        @checker = checker
        @configuration = Healthcheck.configuration
      end

      def execute!
        verbose? ? @controller.render(verbose) : @controller.head(status)
      end

      private

      def verbose?
        @configuration.verbose
      end
    end
  end
end
