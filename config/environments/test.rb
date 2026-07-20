Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.server_timing = true

  config.action_dispatch.show_exceptions = :rescuable

  config.active_record.migration_error = :page_load
  config.active_record.maintain_test_schema = true
end
