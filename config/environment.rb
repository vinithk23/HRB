# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_API_KEY'],
    domain: ENV['SENDGRID_MAIL_DOMAIN'],
    address: ENV['SENDGRID_ADDRESS'],
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

# ActionMailer::Base.smtp_settings = {
#   user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
#   password: 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, # This is the secret sendgrid API key which was issued during API key creation
#   domain: 'example.com',
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   authentication: :plain,
#   enable_starttls_auto: true
# }