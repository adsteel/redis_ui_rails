require_relative "boot"

require "puma"
require "sqlite3"
require "net/smtp"
require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "redis_ui_rails"

module RedisUiRailsDummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
  end
end
