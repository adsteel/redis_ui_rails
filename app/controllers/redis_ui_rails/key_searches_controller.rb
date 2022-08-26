module RedisUiRails
  class KeySearchesController < ApplicationController
    def new
      @instance = Instance.find(params[:id])
    end

    def create
      @instance = Instance.find(params[:id])
      key = params[:key]
      value = @instance.get(params[:key])

      if value.nil?
        flash[:warning] = "No key '#{key}' found in Redis instance '#{@instance.id}'"
        render :new
      else
        redirect_to instance_key_search_path(id: @instance.id, key: key)
      end
    end

    def show
      @instance = Instance.find(params[:id])
      @key = params[:key]
      @value = @instance.get(params[:key])

      if @value.nil?
        flash[:warning] = "No key '#{params[:key]}' found in Redis instance '#{@instance.id}'"
        render :new
      end
    end
  end
end
