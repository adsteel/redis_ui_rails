RedisUiRails::Engine.routes.draw do
  root to: "dashboard#index"

  resources :instances, only: [:show]

  get "instance/:id/keys", to: "keys#show", as: :instance_keys
  get "instance/:id/config", to: "configs#show", as: :instance_config
end
