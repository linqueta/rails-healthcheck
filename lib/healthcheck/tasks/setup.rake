# frozen_string_literal: true

require 'fileutils'

INITIALIZER = 'config/initializers/healthcheck.rb'
OLD_ROUTES = 'config/routes.rb'
NEW_ROUTES = 'config/routes.rb.new'
ROUTES_SETUP = '  Healthcheck.routes(self)'
ROUTES_INIT = 'Rails.application.routes.draw do'

namespace :healthcheck do
  desc 'Install the files and settings to the gem Healthcheck works'
  task :install do
    create_initializer
    mount_route
  end
end

def create_initializer
  FileUtils.mkdir_p(File.dirname(INITIALIZER))
  File.open(INITIALIZER, 'w') { |file| file << settings }
end

def mount_route
  return unless File.exist?(OLD_ROUTES)

  File.open(NEW_ROUTES, 'w') do |new_routes|
    File.foreach(OLD_ROUTES) do |line|
      new_routes.puts(line)
      if line.strip == ROUTES_INIT
        new_routes.puts(ROUTES_SETUP)
        new_routes.puts ''
      end
    end
  end

  File.delete(OLD_ROUTES)
  File.rename(NEW_ROUTES, OLD_ROUTES)
end

def settings
  <<~SETTINGS
    # frozen_string_literal: true

    Healthcheck.configure do |config|
      config.success = 200
      config.error = 503
      config.verbose = false
      config.route = '/healthcheck'
      config.method = :get

      # -- Checks --
      # Check if the db is available
      # config.add_check :database, -> { ActiveRecord::Base.connection.execute('select 1') }
      # Check if the db is available is without pending migrations
      # config.add_check :migrations,-> { ActiveRecord::Migration.check_pending! }
      # Check if the cache is available
      # config.add_check :cache, -> { Rails.cache.read('some_key') }
      # Check if the application required envs are defined
      # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
    end
  SETTINGS
end
