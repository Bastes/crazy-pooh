class ContactMailer < ActionMailer::Base
  include ContactMailerConfiguration

  def contact_request(contact)
    @contact = contact
    mail(:subject => t('contact_mailer.contact_request.subject',
                       :first_name => contact.first_name,
                       :last_name => contact.last_name,
                       :email => contact.email))
  end
end
