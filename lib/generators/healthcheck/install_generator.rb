# frozen_string_literal: true

require 'rails/generators/base'

module Healthcheck
  class InstallGenerator < Rails::Generators::Base
    desc 'It creates an initializer to set the healthcheck settings'
    def create_initializer_file
      create_file(
        'config/initializers/healthcheck.rb',
        <<~HEALTHCHECK_INITIALIZER_TEXT
          # frozen_string_literal: true

          Healthcheck.configure do |config|
            config.success = 200
            config.error = 503
            config.verbose = false
            config.route = '/healthcheck'
            config.method = :get

            # -- Checks --
            # config.add_check :database,     -> { ActiveRecord::Base.connection.execute('select 1') }
            # config.add_check :migrations,   -> { ActiveRecord::Migration.check_pending! }
            # config.add_check :cache,        -> { Rails.cache.read('some_key') }
            # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
          end
        HEALTHCHECK_INITIALIZER_TEXT
      )
      route 'Healthcheck.routes(self)'
    end
  end
end
