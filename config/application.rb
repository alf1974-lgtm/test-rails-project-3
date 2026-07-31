require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module SchoolApi
  class Application < Rails::Application
    config.load_defaults 7.1

    # API-only application
    config.api_only = true
  end
end
