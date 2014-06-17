require 'rubygems'

require 'rails'
require 'rails/all'

require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'active_support/testing/isolation'

require File.expand_path('../../lib/quiet_routes', __FILE__)

class HomeController < ActionController::Base
  def index
    render text: 'Hi there!'
  end

  def status
    head 200
  end
end

class HelperTest < Minitest::Unit::TestCase
  include ActiveSupport::Testing::Isolation

  attr_reader :app, :output

  def setup
    @output = StringIO.new

    # Ruby 1.8 doesn't call self.inherited inside Class.new
    # Config and routes are unreacheable inside the block here.
    @app = Class.new(Rails::Application)

    app.configure do
      config.active_support.deprecation = :notify
      config.secret_token = '685e1a60792fa0d036a82a52c0f97e42'
      config.eager_load = false

      routes {
        root to: 'home#index'
        get '/status', to: 'home#status'
      }
    end
  end

  def initialize!(&block)
    app.configure(&block) if block_given?

    app.initialize!

    Rails.logger = Logger.new(output)
    Rails.logger.formatter = lambda { |s, d, p, m| "#{m}\n" }
  end

  def request(uri)
    Rack::MockRequest.env_for(uri)
  end

  def test_status_url_with_option_by_default
    initialize!

    app.call request('/status')

    assert_match(/Started GET \"\/status\" for  at/, output.string)
  end

  def test_status_url_with_quiet_routes_option
    initialize! { config.quiet_routes = ['/status'] }

    app.call request('/status')

    assert_equal '', output.string
  end

  def test_in_multi_thread_env
    initialize! { config.quiet_routes = ['/status'] }

    th1 = Thread.new do
      sleep 0.1
      app.call request('/status')
    end

    th2 = Thread.new do
      sleep 0.1
      app.call request('/')
    end

    th3 = Thread.new do
      sleep 0.1
      app.call request('/status')
    end

    [th1, th2, th3].map{|i| i.join }

    n = output.string.lines.select{|i| i.match(/Started GET "\/"/) }

    assert_equal n.size, 1
  end

  def test_regular_url
    initialize!

    app.call request('/')

    assert_match(/Started GET \"\/\" for  at/, output.string)
  end
end
