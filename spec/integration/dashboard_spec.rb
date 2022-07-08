require "feature_spec_helper"

RSpec.describe "Dashboard View", type: :feature do
  # Just a simple smoke test to make sure we haven't broken anything.
  # Testing details beyond this isn't worth the time given the current
  # simplicity.
  it "loads without error" do
    visit "redis_ui/"

    expect(page).to have_content "Redis Dashboard"
  end
end
