require "spec_helper"

RSpec.describe RedisUiRails::Config do
  let(:config) { described_class.new }
  let(:hash_instance) do
    {
      id: "test",
      url: "test/url",
      name: "test name",
      enabled: true
    }
  end
  let(:hash_instances) { [hash_instance] }

  before(:each) do
    config.redis_instances = hash_instances
  end

  describe "#ingest" do
    it "slurps hash instances into instance objects" do
      config.ingest

      expect(config.redis_instances.map(&:class)).to contain_exactly(RedisUiRails::ConfigRedisInstance)
    end
  end

  describe "validations" do
    before(:each) { config.ingest }

    context "given a valid instance hash" do
      it "is valid" do
        expect { config.validate! }.not_to raise_error
      end
    end

    context "given an invalid instance hash" do
      let(:hash_instance) { super().tap { |obj| obj.delete(:url) } }

      it "is not valid" do
        expect { config.validate! }.to raise_error(/url/)
      end
    end

    context "given 0 instance hashes" do
      let(:hash_instance) { nil }

      it "is not valid" do
        expect { config.validate! }.to raise_error(/at least one/i)
      end
    end

    context "given duplicate ids" do
      let(:hash_instances) { [hash_instance, hash_instance] }

      it "is not valid" do
        expect { config.validate! }.to raise_error(/duplicate/i)
      end
    end
  end
end
