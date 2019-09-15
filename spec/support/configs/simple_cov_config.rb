# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'

module SimpleCovConfig
  def self.configure
    SimpleCov.formatter = SimpleCov::Formatter::Console
    SimpleCov.minimum_coverage 100
    SimpleCov.start do
      add_filter { |source_file| cover?(source_file.lines) }
    end
  end

  def self.cover?(lines)
    !lines.detect { |line| line.src =~ /(def)/ }
  end
end
