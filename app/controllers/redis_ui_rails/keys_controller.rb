module RedisUiRails
  class KeysController < ApplicationController
    def show
      @instance = Instance.find(params[:id])
      @sample_keys = 50.times.map { @instance.randomkey }.uniq
    end

    def destroy
      @instance = Instance.find(params[:id])
      @instance.del(params[:key])

      flash[:notice] = "Key #{params[:key]} deleted"

      redirect_to new_instance_key_search_path(@instance.id)
    end
  end
end
