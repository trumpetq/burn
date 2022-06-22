rollbar_handler = proc do |options|
  d 'rollbar_handler'
  d options[:exception]
  case options[:exception]
  when ActionController::RoutingError
    d 'routing error'
    d options[:exception].message
    needles = ["wp-admin", "wp-includes", "xmlrpc.php"]
    raise Rollbar::Ignore if options[:message]&.match?(Regexp.union(needles))
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
