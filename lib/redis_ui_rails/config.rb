module RedisUiRails
  class Config
    include ActiveModel::Validations

    validate :validate_redis_instances
    validate :validate_unique_ids
    validate :validate_at_least_one_configured

    def initialize
      self.all_redis_instances = []
    end

    def redis_instances=(arr)
      self.all_redis_instances = arr
    end

    def redis_instances
      all_redis_instances.select(&:enabled?)
    end

    def ingest
      self.redis_instances = Array(all_redis_instances).compact.map do |redis_instance|
        ConfigRedisInstance.new(redis_instance.symbolize_keys)
      end
    end

    private

    attr_accessor :all_redis_instances

    def validate_redis_instances
      unless all_redis_instances.is_a?(Array)
        return errors.add(:redis_instances, "must be an array")
      end

      unless all_redis_instances.all?(&:valid?)
        error_msgs = all_redis_instances.map(&:errors).flatten.map(&:full_messages).flatten

        msg = <<~MSG
          1 or more Redis UI instance hashes are not valid in the configuration.
          #{error_msgs.join(", ")}
        MSG
        errors.add(:base, msg)
      end
    end

    def validate_unique_ids
      duplicate_ids = all_redis_instances.map(&:id)
        .tally
        .select { |id, count| count > 1 }
        .map { |id, count| count }

      return if duplicate_ids.empty?

      errors.add(:base, "Duplicate Redis instance ids not allowed. Found: #{duplicate_ids.uniq}")
    end

    def validate_at_least_one_configured
      return if all_redis_instances.size > 0

      errors.add(:base, "No redis instances configured during initialization. At least one is required.")
    end
  end
end
