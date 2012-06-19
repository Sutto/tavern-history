require 'spec_helper'

describe Tavern::History::Redis do

  let(:redis) { Redis.new(database: 4) }

  let(:base_hub) { Tavern::Hub.new }
  let(:hub)      { Tavern::History::Redis.new base_hub, 'redis-tests', redis }
  after(:each)   { redis.flushdb }

  it_should_behave_like 'a hub with history'

end