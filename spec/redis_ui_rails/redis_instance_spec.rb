require "spec_helper"

RSpec.describe RedisUiRails::RedisInstance do
  let(:options) do
    {
      id: "test",
      url: "//test/url",
      name: "test name",
      resource_links: [
        {
          label: "label",
          url: "url"
        }
      ]
    }
  end
  let(:instance) { described_class.new(options) }

  it "provides accessors to input hash keys" do
    expect(instance.id).to eq(options[:id])
    expect(instance.url).to eq(options[:url])
    expect(instance.name).to eq(options[:name])
  end

  describe "#url" do
    context "given a localhost URL" do
      let(:url) { "redis://localhost:6379/3" }

      it "returns the full URL" do
        instance.actual_url = url

        expect(instance.url).to eq(url)
      end
    end

    context "given non-localhost URLs" do
      let(:sensitive_urls) do
        {
          "redis://fo-some-service.two01.ng.0001.use1.cache.amazonaws.com:6379" => "redis://fo-some-service.two**.ng.****.use*.cache.amazonaws.com:6379",
          "redis://user:password@fo-some-service.two01.ng.0001.use1.cache.amazonaws.com:6379" => "redis://user:*@fo-some-service.two**.ng.****.use*.cache.amazonaws.com:6379"
        }
      end

      it "obscures the URL" do
        sensitive_urls.each do |url, redacted_url|
          instance.actual_url = url

          expect(instance.url).to eq(redacted_url)
        end
      end

      it "can bypass URL obscuring" do
        sensitive_urls.each do |url, _|
          instance.actual_url = url

          expect(instance.url(unredacted: true)).to eq(url)
        end
      end
    end
  end

  describe "validations" do
    context "given a valid set of options" do
      it "is valid" do
        expect { instance.validate! }.not_to raise_error
      end
    end

    context "given a missing :url" do
      let(:options) { super().tap { |obj| obj.delete(:url) } }

      it "is not valid" do
        expect { instance.validate! }.to raise_error(ActiveModel::ValidationError)
      end
    end

    context "given a missing :name" do
      let(:options) { super().tap { |obj| obj.delete(:name) } }

      it "is not valid" do
        expect { instance.validate! }.to raise_error(ActiveModel::ValidationError)
      end
    end

    context "given a missing :id" do
      let(:options) { super().tap { |obj| obj.delete(:id) } }

      it "is not valid" do
        expect { instance.validate! }.to raise_error(ActiveModel::ValidationError)
      end
    end

    context "given a missing :resource_links" do
      let(:options) { super().tap { |obj| obj.delete(:resource_links) } }

      it "is valid" do
        expect { instance.validate! }.not_to raise_error
      end
    end

    context "given a missing resource_links: :url" do
      let(:options) { super().tap { |obj| obj[:resource_links][0].delete(:url) } }

      it "is not valid" do
        expect { instance.validate! }.to raise_error(ActiveModel::ValidationError)
      end
    end

    context "given a missing resource_links: :label" do
      let(:options) { super().tap { |obj| obj[:resource_links][0].delete(:label) } }

      it "is not valid" do
        expect { instance.validate! }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end
