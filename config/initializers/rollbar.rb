rollbar_handler = proc do |options|
  case options[:exception]
  when ActionController::RoutingError
    message = options[:exception].message
    needles = ["wp-admin", "wp-includes", "xmlrpc.php"]
    raise Rollbar::Ignore if message&.match?(Regexp.union(needles))
  end
end

Rollbar.configure do |config|
  config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]

  if Rails.env.test?
    config.enabled = false
  end
  config.before_process << rollbar_handler

  config.environment = ENV["ROLLBAR_ENV"].presence || Rails.env
end
