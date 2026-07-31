source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.1.0"
gem "sqlite3", "~> 1.6"
gem "puma", "~> 6.0"
gem "bootsnap", ">= 1.4.4", require: false
gem "rack-cors"
gem "active_model_serializers", "~> 0.10.0"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "listen", "~> 3.3"
end
