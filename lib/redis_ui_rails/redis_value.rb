module RedisUiRails
  class RedisValue
    MAX_RETRIEVED_LIST_LENGTH = 10

    class << self
      def find(key, instance:)
        case instance.type(key)
        when "string"
          instance.get(key)
        when "hash"
          instance.hgetall(key)
        when "list"
          max = [instance.llen(key), MAX_RETRIEVED_LIST_LENGTH].min
          instance.lrange(key, 0, max)
        when "set"
          instance.srandmember(key, MAX_RETRIEVED_LIST_LENGTH)
        when "none"
          raise RedisValueMissing.new("Unable to find key '#{key}' in Redis instance '#{name}'")
        else
          raise UnsupportedValueType.new("Unsupported Redis key value type of '#{instance.type(key)}'")
        end
      end
    end
  end
end
