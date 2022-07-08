require_relative "./spec_helper"
require_relative "./support/dummy/config/environment"
require "capybara/rspec"
require "webdrivers"

Capybara.configure do |c|
  c.app = RedisUiRailsDummy::Application
  c.javascript_driver = :selenium_chrome
end
