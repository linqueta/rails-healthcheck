# frozen_string_literal: true

module Healthcheck
  class Configuration
    SETTINGS = %i[success error verbose route route method parallel all].freeze

    attr_accessor(*SETTINGS)

    def initialize
      SETTINGS.each { |key, _| instance_variable_set("@#{key}", nil) }
    end
  end
end
