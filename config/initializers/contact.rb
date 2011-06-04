# getting contacts informations for emailing
module ContactMailerConfiguration
  SEND_FROM, SEND_TO =
    begin
      contact_file = Rails.root.join('config', 'contact.yml')
      if !File.exists?(contact_file) && Rails.env == "production"
        # from the ENV hash (for heroku)
        [ ENV['SEND_FROM'], ENV['SEND_TO'] ]
      else
        YAML.load_file(contact_file)[Rails.env].
          values_at('send_from', 'send_to')
      end
    end

  def self.included(base)
    Rails.logger.debug "SEND_FROM: " + SEND_FROM
    Rails.logger.debug "SEND_TO: " + SEND_TO
    base.default :from => SEND_FROM, :sender => SEND_FROM, :to => SEND_TO
  end
end
