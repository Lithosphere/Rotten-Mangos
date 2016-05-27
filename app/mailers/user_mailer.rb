class UserMailer < ActionMailer::Base
  default from: "yoooooo@example.com"

  def delete_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account has been deleted')
  end
  
end
