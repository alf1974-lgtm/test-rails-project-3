# config/application.rb
require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module SchoolApi
  class Application < Rails::Application
    config.load_defaults 7.1

    # API-only mode
    config.api_only = true

    # Allow all origins for development convenience
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
  end
end
