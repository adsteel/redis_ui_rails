require "feature_spec_helper"

RSpec.describe "Instance Key Search and Delete", type: :feature do
  let(:mock_redis) { MockRedis.new }
  let(:instance) { RedisUiRails::Instance.find("dummy") }

  before do
    allow(Redis).to receive(:new).and_return(mock_redis)
  end

  it "allows the user to search and delete by key", js: true do
    instance.set("test-key", "test-value")

    visit "redis_ui/instance/dummy/key_search/new"

    fill_in :key, with: "test-key"

    click_button "Search"

    expect(page).to have_content "test-value"

    click_button "Delete Key"

    page.driver.browser.switch_to.alert.dismiss

    expect(page).to have_content "test-value"

    click_button "Delete Key"

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content "test-key deleted"
  end
end
