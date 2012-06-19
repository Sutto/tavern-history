module Tavern
  module History
    class Base

      attr_reader :hub

      def initialize(hub)
        @hub = hub
        hub.subscribe('') { |event| persist event }
      end

      def history(channel, limit = 10)
        identifiers = identifiers_for channel, limit
        fetch identifiers
      end

      def persist(event)
        identifier = record event
        each_subchannel event do |channel|
          add_record channel, identifier
        end
        true
      end

      def subscribe(*args, &blk);   hub.subscribe(*args, &blk);   end
      def unsubscribe(*args, &blk); hub.unsubscribe(*args, &blk); end
      def publish(*args, &blk);     hub.publish(*args, &blk);     end

      # TODO: We need to delegate all normal hub methods to the hub.
      # On creation, we need to subscribe to the lowest level hub,
      # and then have something to record it.

      private

      # Given a single event, records them and returns the identifiers that match them.
      def record(entry)
        raise NotImplementedError
      end

      def fetch(identifiers)
        raise NotImplementedError
      end

      # Given a record identifier and a channel name, will
      # add the specified record to the given channel.
      def add_record(channel_name, identifier)
        raise NotImplementedError
      end

      # Gets the specified number of identifers from the given channel.
      def identifiers_for(channel, limit)
        raise NotImplementedError
      end

      def each_subchannel(event)
        parts = event[:path_parts].dup
        while parts.any?
          yield parts.join ':'
          parts.pop
        end
      end

    end
  end
end