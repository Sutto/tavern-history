# tavern-history

Tavern history adds basic history to the events published with tavern,
letting you retrieve a historical record of things that have happened.

How does it work you ask? easy! Tavern history uses a backend to store
entities (out of the box, it's built to work with Redis at the moment)
as well as a generaled channel to events mapping.

The redis backend is the primary backend at the moment and makes uses of redis
hashes (for the actual event storage) and sorted sets for the actual
historical channel tracking.

## Installation

Add this line to your application's Gemfile:

    gem 'tavern-history'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tavern-history

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
