require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  config.server_timing = true
  config.active_support.deprecation = :stderr
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
end
