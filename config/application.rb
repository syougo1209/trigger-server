require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppName
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end




[
  {
    from: "shibuya_sta",
    to: "shinagawa_sta",
    leave_at: "0:13",
    arrive_at: "0:25",
    line: [
      {
        name: "山手線",
        direction: "品川・東京方面（内回り）",
        leave_at: "0:13",
        arrive_at: "0:25",
        stop_at: [
          {
            station_code: "ebisu_sta",
            station_name: "恵比寿駅"
          },
          {
            station_code: "meguro_sta",
            station_name: "目黒駅"
          },
          {
            station_code: "gotanda_sta",
            station_name: "五反田駅"
          },
          {
            station_code: "osaki_sta",
            station_name: "大崎駅"
          }
        ]
      }
    ]
  }
]
