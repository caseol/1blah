class ContactMailer < ActionMailer::Base
  #default :from => "from@example.com"
  default :to => "contato@1blah.com"

  def send_contact(contact)
    @contact = contact
    mail(:subject => "Contato pelo site - #{contact.subject}", :from => contact.email)
  end
end
