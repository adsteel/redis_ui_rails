module RedisUiRails
  class KeySearchesController < ApplicationController
    def new
      @instance = Instance.find(params[:id])
    end

    def create
      @instance = Instance.find(params[:id])
      key = params[:key]

      value = case @instance.type(key)
      when "none" then nil
      else
        "found"
      end

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
      @value = RedisValue.find(@key, instance: @instance)

      if @value.nil?
        flash[:warning] = "No key '#{params[:key]}' found in Redis instance '#{@instance.id}'"
        render :new
      end
    rescue => e
      flash[:error] = e.message
      render :new
    end
  end
end
