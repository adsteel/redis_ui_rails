module RedisUiRails
  class DashboardController < ApplicationController
    def index
      @instances = Instance.all
    end
  end
end
