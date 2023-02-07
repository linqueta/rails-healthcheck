# frozen_string_literal: true

module Healthcheck
  class Router
    def self.mount(router)
      router.send(
        Healthcheck.configuration.method,
        Healthcheck.configuration.route => 'healthcheck/healthchecks#check',
        as: :rails_health_check
      )
    end
  end
end
