require 'redis'
require 'multi_json'

module Tavern
  module History
    class Redis < Base

      attr_reader :redis

      def initialize(hub, keyspace, redis = ::Redis.current)
        super hub
        @redis       = redis
        @base_key    = "#{keyspace}:history"
        @counter     = "#{@base_key}:counter"
        @records     = "#{@base_key}:records"
        @stream_base = "#{@base_key}:entries"
      end

      private

      def generate_id
        @redis.incr @counter
      end

      # Given a single event, records them and returns the identifiers that match them.
      def record(entry)
        dumped     = MultiJson.encode(entry)
        identifier = generate_id
        @redis.hset @records, identifier, dumped
        identifier
      end

      def fetch(identifiers)
        records = identifiers.any? ? @redis.hmget(@records, identifiers) : []
        records.map do |record|
          MultiJson.decode record
        end.compact
      end

      # Given a record identifier and a channel name, will
      # add the specified record to the given channel.
      def add_record(channel_name, identifier)
        stream = "#{@stream_base}:#{channel_name}"
        current_score = (Time.now.to_f * 1000).floor
        @redis.zadd stream, current_score, identifier
      end

      # Gets the specified number of identifers from the given channel.
      def identifiers_for(channel_name, limit)
        stream = "#{@stream_base}:#{channel_name}"
        @redis.zrevrange stream, 0, limit - 1
      end

    end
  end
end