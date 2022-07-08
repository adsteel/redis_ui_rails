require "feature_spec_helper"

RSpec.describe "Instance Config", type: :feature do
  let(:mock_redis) { MockRedis.new }
  # Just a simple smoke test to make sure we haven't broken anything.
  # Testing details beyond this isn't worth the time given the current
  # simplicity.
  before do
    allow(Redis).to receive(:new).and_return(mock_redis)
  end

  it "loads without error" do
    visit "redis_ui/instance/dummy/config"

    expect(page).to have_content "Server Config"
  end
end
