# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
Dir.glob('lib/healthcheck/tasks/*.rake').each { |r| import r }

RSpec::Core::RakeTask.new(:spec)

task default: :spec
