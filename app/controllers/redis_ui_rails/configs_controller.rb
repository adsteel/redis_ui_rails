module RedisUiRails
  class ConfigsController < ApplicationController
    def show
      @instance = Instance.find(params[:id])
    end
  end
end
