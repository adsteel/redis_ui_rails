module RedisUiRails
  class ConfigRedisInstance
    include ActiveModel::Validations

    REQUIRED_OPTIONS_KEYS = [:url, :name, :id].freeze

    validate :validate_options
    validate :validate_resource_links

    def initialize(hash)
      self.options = hash.symbolize_keys
      self.actual_url = options[:url]
      self.name = options[:name]
      self.id = options[:id]
      self.resource_links = options[:resource_links] || []
      self.enabled = options.key?(:enabled) ? options[:enabled] : true
    end
    attr_accessor :actual_url, :name, :id, :options, :resource_links

    def enabled?
      enabled
    end

    def url(unredacted: false)
      return actual_url if unredacted

      uri = URI(actual_url)

      uri.host = uri.host.to_s.tr("0-9", "*") unless /localhost/.match?(uri.host.to_s)

      uri.password = "*" if uri.user

      uri.to_s
    end

    private

    attr_accessor :enabled

    def validate_options
      return if (REQUIRED_OPTIONS_KEYS - options.keys).empty?

      errors.add(:base, "Must have the following keys: '#{REQUIRED_OPTIONS_KEYS.join(", ")}'")
    end

    def validate_resource_links
      return if resource_links.all? do |resource_link|
        resource_link[:url].present? && resource_link[:label].present?
      end

      errors.add(:base, "All :resource_links must have :url and :label keys")
    end
  end
end
