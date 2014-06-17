# Quiet Routes
[![Continuous Integration status](https://secure.travis-ci.org/evrone/quiet_assets.png)](http://travis-ci.org/evrone/quiet_assets)

Quiet Routes has been made in referrence to [quiet_assets](https://github.com/evrone/quiet_assets).
This is turns off the Rails particular log.
For example, this can suppress the access log of ping target from the load balancer.

Support Ruby on Rails = 4.1

## Installation

To install, add this line to development group in your Gemfile:

    gem 'quiet_routes'

Then, from the command line, run:

    $ bundle

## Usage

After installation, place the following in your `config/application.rb` file:

    config.quiet_assets = %w(pass_to_silent_route_list)

## Contributing

1. Fork it ( https://github.com/yusuket/quiet_routes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
