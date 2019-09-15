# frozen_string_literal: true

require 'healthcheck'
require 'rails'

module Healthcheck
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
