module RedisUiRails
  class Engine < ::Rails::Engine
    isolate_namespace RedisUiRails

    initializer :assets, group: :all do |app|
      config.assets.precompile << "redis_ui_rails/application.css"
      config.assets.precompile << "redis_ui_rails/application.js"
      config.assets.paths << root.join("assets", "stylesheets").to_s
      config.assets.paths << root.join("assets", "javascripts").to_s
    end
  end
end
