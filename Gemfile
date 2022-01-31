source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

gem "aasm"
gem "bootsnap", require: false
gem "cssbundling-rails"
gem "config"
gem "devise"
gem "enumerize"
gem "image_processing"
# gem "importmap-rails" # Remove code
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
gem "sassc-rails"
gem "simple_form"
gem "slim-rails"
# gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "standard"
end

group :development do
  gem "annotate", github: "dabit/annotate_models", branch: "rails-7"
  gem "brakeman"
  gem "bullet"
  gem "letter_opener"
  # gem "rack-mini-profiler"
  gem "rubocop"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
