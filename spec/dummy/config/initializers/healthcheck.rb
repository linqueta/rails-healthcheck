# frozen_string_literal: true

Healthcheck.configure do |config|
  config.success = 200
  config.error = 503
  config.verbose = false
  config.route = '/healthcheck'
  config.method = :get

  # -- Checks --
  # Just for simulate successes and errors in specs
  config.add_check :date_check, -> { raise StandardError if Time.current.year == 1969 }
  config.add_check :sum_check, -> { [1,2,3].sum == 6 }
end
