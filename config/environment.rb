# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.default_options = { from: ENV["EMAIL_FROM"] } # example@site.com
ActionMailer::Base.default_url_options = { host: ENV["EMAIL_HOST"] } # site.com
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
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
