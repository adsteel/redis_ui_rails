require "spec_helper"

RSpec.describe RedisUiRails do
  after(:each) do
    described_class.remove_instance_variable(:@config)
  end

  it "is configurable" do
    expect {
      described_class.configure do |config|
        config.redis_instances = [
          {
            id: "test",
            url: "test/url",
            name: "test name"
          }
        ]
      end
    }.not_to raise_error
  end

  it "raises an error if configured incorrectly" do
    expect {
      described_class.configure do |config|
        config.redis_instances = []
      end
    }.to raise_error(ActiveModel::ValidationError)
  end
end
