# frozen_string_literal: true

module Healthcheck
  class Configuration
    SETTINGS = %i[success error verbose route method checks].freeze

    attr_accessor(*SETTINGS)

    def initialize
      SETTINGS.each { |key, _| instance_variable_set("@#{key}", nil) }
      clear!
    end

    def add_check(name, block)
      @checks << Check.new(name, block)
    end

    def clear!
      @checks = []
    end
  end
end
