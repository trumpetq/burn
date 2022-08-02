source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "aasm"
gem "acts_as_list"
gem "aws-sdk-s3", require: false
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "config"
gem "country_select"
gem "date_validator"
gem "devise" # FIX: Users::SessionsController when > 4.8.1
gem "discard"
gem "enumerize"
gem "image_processing"
gem "jbuilder"
gem "jsbundling-rails"
gem "money-rails"
gem "pagy"
gem "pg"
gem "phony_rails"
gem "pundit"
gem "puma"
gem "rails"
gem "rainbow"
gem "redis"
gem "rollbar"
gem "ruby-vips"
gem "sassc-rails"
gem "simple_form"
gem "slim-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "validate_url"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "standard"
end

group :development do
  gem "annotate"
  gem "brakeman"
  gem "bullet"
  gem "letter_opener"
  gem "rubocop"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
