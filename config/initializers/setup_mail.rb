class SetupMail
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "1blah.com",
    :user_name            => "admin@1blah.com",
    :password             => "1qa2ws3edzxc",
    :authentication       => "plain",
    :enable_starttls_auto => true  
  }
end