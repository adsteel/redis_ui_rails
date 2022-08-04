# RedisUiRails

A mountable UI Rails engine for inspecting your Redis instances. The teams that will get the most value out of this engine are teams that cannot use the Rails console to inspect their production Redis instances.

## Installation

1. Add this line to your application's Gemfile:

```ruby
gem 'redis_ui_rails'
```

2. In `config/routes.rb`, mount the engine

```ruby
Rails.application.routes.draw do
  mount RedisUiRails::Engine => "/redis_ui"
end
```

3. Precompile your assets

```bash
cd path/to/app/root
bundle exec rake assets:precompile
```

4. Configure your Redis UI engine.

Example:

```ruby
# config/initializers/redis_ui_rail.rb

# Each "instance" is a hash, with the following symbolized key structure:
#   :id (required) The ID used in the URL for this instance.
#   :name (required) The name that differentiates this Redis instance from others.
#   :url (required) The URL of the redis instance.
#   :resource_links (optional) Quick links to resources related to this instance.
#   :enabled (optional) Allows enabling per environment. Defaults to true.
#
RedisUiRails.configure do |config|
  config.redis_instances = [
    {
      id: :local,
      name: "Local Queue and Cache", # many apps share a queue and cache Redis locally
      url: ENV["REDIS_URL"],
      enabled: Rails.env.development? || Rails.env.test?
    },
    {
      id: :cache,
      name: "Cache",
      url: ENV.fetch("REDIS_CACHE_URL"), # many apps have separate queue and cache Redis instances in production
      resource_links: [
        {
          label: "Custom Datadog Dashboard",
          url: "https://myorg.datadoghq.com/path/to/your/dashhboard"
        }
      ],
      enabled: Rails.env.production?
    }
  ]
end
```

## Local Development

1. Requirements:

- Ruby >= 3.0
- Direnv (don't forget your [rc file hook](https://direnv.net/docs/installation.html))

2. Initial setup

```
bundle install
cp .rspec.example .rspec
cp .env.example .env
direnv allow
```

3. Run tests

```
bundle exec rspec spec
```
