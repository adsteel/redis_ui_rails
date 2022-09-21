module RedisUiRails
  class InstancesController < ApplicationController
    def show
      @instance = Instance.find(params[:id])
    end
  end
end
