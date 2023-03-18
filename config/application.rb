require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Moscow"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ru

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_options = {from: ENV["EMAIL_FROM"]} # example@site.com
    config.action_mailer.default_url_options = { host: ENV["EMAIL_HOST"] } # site.com
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:         'smtp.yandex.ru',
      port:            465,
      domain:          'yandex.ru',
      user_name:       ENV["EMAIL_USERNAME"], # username_email@site.com
      password:        ENV["EMAIL_PASSWORD"],
      authentication:  'plain',
      ssl:             true,
      tsl:             true,
      enable_starttls: true,
      open_timeout:    10,
      read_timeout:    10 }

    config.active_storage.variant_processor = :mini_magick
  end
end
