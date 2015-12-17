# Quiet Routes
[![Build Status](https://travis-ci.org/csouls/quiet_routes.svg)](https://travis-ci.org/csouls/quiet_routes)

Quiet Routes implemented with reference to [quiet_assets](https://github.com/evrone/quiet_assets).

This is turns off the Rails particular log.

e.g. Will be able to suppress the health check log of AWS ELB or other load balancers.

Support Ruby on Rails = 4.1

## Installation

To install, add this line to development group in your Gemfile:

    gem 'quiet_routes'

Then, from the command line, run:

    $ bundle

## Usage

After installation, place the following in your `config/application.rb` file:

    config.quiet_routes = %w(/silent_route1 /silent_route2 ...)

## Contributing

1. Fork it ( https://github.com/yusuket/quiet_routes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
