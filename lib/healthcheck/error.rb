# frozen_string_literal: true

module Healthcheck
  class Error
    attr_accessor :name, :exception, :message

    def initialize(name, exception, message)
      @name = name
      @exception = exception.to_s
      @message = message&.squish
    end
  end
end
