# getting credentials for emailing
email_file = Rails.root.join('config/email.yml')
SMTP_SETTINGS =
  if !File.exists?(email_file) && Rails.env == "production"
    # from the ENV hash (for heroku)
    {
      'address'              => ENV['SENDGRID_ADDRESS'],
      'port'                 => ENV['SENDGRID_PORT'],
      'authentication'       => ENV['SENDGRID_AUTHENTICATION'],
      'user_name'            => ENV['SENDGRID_USER_NAME'],
      'password'             => ENV['SENDGRID_PASSWORD'],
      'domain'               => ENV['SENDGRID_DOMAIN'],
      'enable_starttls_auto' => ENV['SENDGRID_ENABLE_STARTTLS_AUTO']
    }
  else
    # get credentials from YML file
    YAML::load(File.open(email_file))[Rails.env]
  end

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => SMTP_SETTINGS['address'],
  :port                 => SMTP_SETTINGS['port'],
  :authentication       => SMTP_SETTINGS['authentication'],
  :user_name            => SMTP_SETTINGS['user_name'],
  :password             => SMTP_SETTINGS['password'],
  :domain               => SMTP_SETTINGS['domain'],
  :enable_starttls_auto => SMTP_SETTINGS['enable_starttls_auto']
}
