# config/application.rb
require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module SchoolApi
  class Application < Rails::Application
    config.load_defaults 7.1

    # API-only application
    config.api_only = true

    # CORS — allow all origins in development
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*",
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
