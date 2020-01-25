# frozen_string_literal: true

Rails.application.routes.draw do
  Healthcheck.routes(self)
end
