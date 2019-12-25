# [Rails::Healthcheck][gem_page]

[![Build Status][travis_status_image]][travis_page]
[![Maintainability][code_climate_maintainability_image]][code_climate_maintainability_page]
[![Test Coverage][code_climate_test_coverage_image]][code_climate_test_coverage_page]
[![Gem Version][gem_version_image]][gem_version_page]

A simple way to configure a healthcheck route for a Rails application

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-healthcheck'
```

and run:

```
rails generate healthcheck:install
```

## Settings
Set the settings in the file _config/initializers/healthcheck.rb_:

```ruby
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
  # Check if the db is available and without pending migrations
  # config.add_check :migrations,-> { ActiveRecord::Migration.check_pending! }
  # Check if the cache is available
  # config.add_check :cache, -> { Rails.cache.read('some_key') }
  # Check if the application required envs are defined
  # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
end
```

### Verbose errors
When happen an error and verbose is enabled (`config.verbose = true`), the response will be like this:

```json
{
    "code": 503,
    "errors": [
        {
            "name": "migrations",
            "exception": "ActiveRecord::PendingMigrationError",
            "message": "Migrations are pending. To resolve this issue, run: bin/rails db:migrate RAILS_ENV=production"
        },
        {
            "name": "environments",
            "exception": "Dotenv::MissingKeys",
            "message": "Missing required configuration key: [\"RAILS_ENV\"]"
        }
    ]
}
```

### Requests

- Success
```
curl -i localhost:3000/healthcheck

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: text/html
Cache-Control: no-cache
X-Request-Id: cbc9fdd0-8090-4927-b061-1e82bcf2e039
X-Runtime: 0.003599
Transfer-Encoding: chunked
```

- Error
```
curl -i localhost:3000/healthcheck

HTTP/1.1 503 Service Unavailable
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: text/html
Cache-Control: no-cache
X-Request-Id: e07eb20f-7d32-4f1a-86ad-32403de2b19a
X-Runtime: 0.033772
Transfer-Encoding: chunked
```

- Error (Verbose)
```
curl -i localhost:3000/healthcheck

HTTP/1.1 503 Service Unavailable
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
Cache-Control: no-cache
X-Request-Id: 8fa5e69a-bfe3-4bbc-875b-ce86f4269467
X-Runtime: 0.019992
Transfer-Encoding: chunked

{"code":503,"errors":[{"name":"zero_division","exception":"ZeroDivisionError","message":"divided by 0"}]}
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
[gem_version_image]: https://badge.fury.io/rb/rails-healthcheck.svg
[gem_version_page]: https://rubygems.org/gems/rails-healthcheck