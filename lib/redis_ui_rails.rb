require "singleton"
require "rails"
require "active_model"
require "forwardable"
require "uri"
require "redis"

require "redis_ui_rails/version"
require "redis_ui_rails/redis_instance"
require "redis_ui_rails/config"
require "redis_ui_rails/engine"

module RedisUiRails
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)

    config.ingest
    config.validate!
  end
end
