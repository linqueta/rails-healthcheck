# frozen_string_literal: true

require 'json_matchers/rspec'

module JsonMatchersConfig
  def self.configure
    JsonMatchers.schema_root = 'spec/schemas'
  end
end
