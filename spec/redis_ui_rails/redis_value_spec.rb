require "spec_helper"

RSpec.describe RedisUiRails::RedisValue do
  describe "#find" do
    let(:mock_redis) { MockRedis.new }
    let(:config_redis_instance) { RedisUiRails::ConfigRedisInstance.new(name: "dummy") }
    let(:instance) { RedisUiRails::Instance.new(config_redis_instance) }
    let(:result) { find! }

    def find!
      described_class.find(key, instance: instance)
    end

    before do
      allow(Redis).to receive(:new).and_return(mock_redis)
    end

    context "given a string key" do
      let(:key) { "key" }
      let(:value) { "val" }

      before(:each) { mock_redis.set(key, value) }

      it "returns the value" do
        expect(result).to eq(value)
      end
    end

    context "given a hash key" do
      let(:key) { "key" }
      let(:value) { {"value" => "1"} }

      before(:each) { mock_redis.hset(key, value) }

      it "returns the value" do
        expect(result).to eq(value)
      end
    end

    context "given a list key" do
      let(:key) { "key" }
      let(:value) { "value" }

      before(:each) { mock_redis.lpush(key, value) }

      it "returns the value" do
        expect(result).to eq([value])
      end
    end

    context "given a set key" do
      let(:key) { "key" }
      let(:value) { "value" }

      before(:each) { mock_redis.sadd(key, value) }

      it "returns the value" do
        expect(result).to eq([value])
      end
    end

    context "given no value" do
      let(:key) { "missing" }

      it "raises an error" do
        expect { find! }.to raise_error(RedisUiRails::RedisValueMissing)
      end
    end

    context "given an unsupported value type" do
      let(:key) { "unsupported" }

      before(:each) { allow(instance).to receive(:type).and_return("other") }

      it "raises an error" do
        expect { find! }.to raise_error(RedisUiRails::UnsupportedValueType)
      end
    end

    describe "trunaction of values" do
      context "given a very long list" do
        let(:key) { "key" }
        let(:large_size) { 100 }

        before(:each) do
          large_size.times { |i| mock_redis.lpush(key, i) }
        end

        it "truncates the returned list" do
          expect(result.size).to be < large_size
        end
      end

      context "given a very long set" do
        let(:key) { "key" }
        let(:large_size) { 100 }

        before(:each) do
          large_size.times { |i| mock_redis.sadd(key, i) }
        end

        it "truncates the returned list" do
          expect(result.size).to be < large_size
        end
      end
    end
  end
end
