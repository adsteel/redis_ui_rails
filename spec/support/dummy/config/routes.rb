Rails.application.routes.draw do
  mount RedisUiRails::Engine => "/redis_ui"
end
