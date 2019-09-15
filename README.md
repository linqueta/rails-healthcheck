# [Rails::Healthcheck][gem_page]

[![Build Status][travis_status_image]][travis_page]
[![Maintainability][code_climate_maintainability_image]][code_climate_maintainability_page]
[![Test Coverage][code_climate_test_coverage_image]][code_climate_test_coverage_page]

A simple way to configure a healthcheck route for a Rails application

## Instalation

Add this line to your application's Gemfile:

```ruby
gem 'rails-healthcheck'
```

and run:

```
rails healthcheck:install
```

## Settings
Set the settings in the file _config/initializers/healthcheck.rb_:

```ruby
# frozen_string_literal: true.

Rails::HealthCheck.configure do |config|
  config.success_http_code = 200
  config.error_http_code = 503
  config.verbose_errors = false
  config.route = '/healthcheck'
  config.method = :get
  config.parallel = true
  config.execute_all = false

  # -- Checks --
  # Check if the db is available
  # config.add_check :database_ok, -> { ActiveRecord::Base.connection.execute('select 1') }
  # Check if the db is available is without pending migrations
  # config.add_check :migrations_ok,-> { ActiveRecord::Migration.check_pending! }
  # Check if the cache is available
  # config.add_check :cache_ok, -> { Rails.cache.read('some_key') }
  # Check if the application required envs are defined
  # config.add_check :environments_ok, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
end
```

### Verbose errors
When happen an error and verbose errors is enabled, the response will be like this:

```json
{
    "code": 503,
    "errors": [
        {
            "name": "migrations_ok",
            "message": "Migrations are pending. To resolve this issue, run: bin/rails db:migrate RAILS_ENV=production"
        },
        {
            "name": "environments_ok",
            "message": "Missing required configuration key: [\"RAILS_ENV\"] (Dotenv::MissingKeys)"
        }
    ]
}
```

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License][mit_license_page].

## Code of Conduct

Everyone interacting in the Rails::Healthcheck project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct][code_of_conduct_page].

[gem_page]: https://github.com/linqueta/rails-healthcheck
[code_of_conduct_page]: https://github.com/linqueta/rails-healthcheck/blob/master/CODE_OF_CONDUCT.md
[mit_license_page]: https://opensource.org/licenses/MIT
[contributor_convenant_page]: http://contributor-covenant.org
[travis_status_image]: https://travis-ci.org/linqueta/rails-healthcheck.svg?branch=master
[travis_page]: https://travis-ci.org/linqueta/rails-healthcheck
[code_climate_maintainability_image]: https://api.codeclimate.com/v1/badges/670d851a6c06f77fa36e/maintainability
[code_climate_maintainability_page]: https://codeclimate.com/github/linqueta/rails-healthcheck/maintainability
[code_climate_test_coverage_image]: https://api.codeclimate.com/v1/badges/670d851a6c06f77fa36e/test_coverage
[code_climate_test_coverage_page]: https://codeclimate.com/github/linqueta/rails-healthcheck/test_coverage
