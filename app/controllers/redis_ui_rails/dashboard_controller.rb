module RedisUiRails
  class DashboardController < ApplicationController
    def index
      @redis_instances = RedisUiRails.config.redis_instances
    end
  end
end
