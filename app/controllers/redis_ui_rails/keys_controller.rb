module RedisUiRails
  class KeysController < ApplicationController
    def show
      @instance = Instance.find(params[:id])
      @sample_keys = 50.times.map { @instance.randomkey }.uniq
    end
  end
end
