class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@unlok.in"
  layout 'mailer'

   def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to Unlok.in')
  end
end
