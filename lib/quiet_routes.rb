require "quiet_routes/version"
require "logger"

module QuietRoutes
  class Engine < ::Rails::Engine
    # Set as empty array but user can override it
    config.quiet_routes = []

    initializer 'quiet_routes' do |app|
      next unless app.config.quiet_routes
      QUIET_PATHS = app.config.quiet_routes
      KEY = 'quiet_assets.old_level'
      app.config.assets.logger = false

      Rails::Rack::Logger.class_eval do
        def call_with_quiet_routes(env)
          begin
            if QUIET_PATHS.include?(env['PATH_INFO'])
              env[KEY] = Rails.logger.level
              Rails.logger.level = Logger::ERROR
            end
            call_without_quiet_routes(env)
          ensure
            Rails.logger.level = env[KEY] if env[KEY]
          end
        end
        alias_method_chain :call, :quiet_routes
      end
    end
  end
end
