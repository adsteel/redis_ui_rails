# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require_relative "../lib/redis_ui_rails"
require "pry"
require "mock_redis"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
  config.expose_dsl_globally = true
  if config.files_to_run.one?
    config.default_formatter = "doc"
  end
end
