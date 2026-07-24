source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "rails", "~> 7.1.0"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 6.0"
gem "rack-cors"

group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers", "~> 5.0"
end

group :development do
  gem "web-console"
end
