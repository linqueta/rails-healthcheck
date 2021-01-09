# [Rails::Healthcheck][gem_page]

[![Gem Version][gem_version_image]][gem_version_page]
[![Build Status][travis_status_image]][travis_page]
[![Maintainability][code_climate_maintainability_image]][code_climate_maintainability_page]

A simple way to configure a healthcheck route in Rails applications

## Table of Contents
- [Getting started](#getting-started)
  - [Installation](#installation)
  - [Settings](#settings)
  - [Custom Response](#custom-response)
  - [Verbose Errors](#verbose-errors)
  - [Ignoring logs](#ignoring-logs)
    - [Lograge](#lograge)
    - [Datadog](#lograge)
  - [Requests Examples](#requests-examples)
- [Contributing](#contributing)
- [License](#license)

## Getting started

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-healthcheck'
```

and run the command bellow to create the initializer:

```
rails generate healthcheck:install
```

### Settings

You can set the settings in the initializer file (_config/initializers/healthcheck.rb_):

```ruby
# frozen_string_literal: true

Healthcheck.configure do |config|
  config.success = 200
  config.error = 503
  config.verbose = false
  config.route = '/healthcheck'
  config.method = :get

  # -- Custom Response --
  # config.custom = lambda { |controller, checker|
  #   return controller.render(plain: 'Everything is awesome!') unless checker.errored?
  #   controller.verbose? ? controller.verbose_error(checker) : controller.head_error
  # }

  # -- Checks --
  # config.add_check :database,     -> { ActiveRecord::Base.connection.execute('select 1') }
  # config.add_check :migrations,   -> { ActiveRecord::Migration.check_pending! }
  # config.add_check :cache,        -> { Rails.cache.read('some_key') }
  # config.add_check :environments, -> { Dotenv.require_keys('ENV_NAME', 'ANOTHER_ENV') }
end
```

### Custom Response

You can override the configs `success`, `error` and `verbose` and write your custom behaviour for the healthcheck api using the field `custom` in the initializer:

```ruby
Healthcheck.configure do |config|
  # ...

  # -- Custom Response --
  config.custom = lambda { |controller, checker|
    controller.render json: { field_name: 'my custom field value' } unless checker.errored?
    ...
  }

  # ...
end
```

Pass a `lambda` or `proc` receiving the params `controller` and `checker` to use it correctly. To use checker, you can see the avialable methods [here][checker_url] and [how][healthcheck_controller_url] it is implemented on HealthcheckController.

### Verbose Errors

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

## Ignoring logs

If you want to ignore Healthcheck request logs, you can use these options:

### [Lograge](https://github.com/roidrage/lograge)

```ruby
# config/environments/production.rb

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.ignore_actions = [Healthcheck::CONTROLLER_ACTION]
end
```

### [Datadog](https://github.com/roidrage/lograge)

```ruby
# config/environments/production.rb

filter = Datadog::Pipeline::SpanFilter.new do |span|
  span.name == 'rack.request' && span.get_tag('http.url') == Healthcheck.configuration.route
end

Datadog::Pipeline.before_flush(filter)
```

### Requests Examples

- Success

```shell
curl -i localhost:3000/healthcheck

HTTP/1.1 200 OK
```

- Error
```shell
curl -i localhost:3000/healthcheck

HTTP/1.1 503 Service Unavailable
```

- Error (Verbose)
```shell
curl -i localhost:3000/healthcheck

HTTP/1.1 503 Service Unavailable
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
[gem_version_image]: https://badge.fury.io/rb/rails-healthcheck.svg
[gem_version_page]: https://badge.fury.io/rb/rails-healthcheck
[checker_url]: https://github.com/linqueta/rails-healthcheck/blob/master/lib/healthcheck/checker.rb
[healthcheck_controller_url]: https://github.com/linqueta/rails-healthcheck/blob/master/app/controllers/healthcheck/healthchecks_controller.rb
