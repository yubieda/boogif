class UserMailer < ActionMailer::Base
  
  default from: "BOOGiF Support <boogifdev@gmail.com>"
  
  def account_confirmation(user)
    @user = user
    @root_url = root_url
    @help_url = help_url
    mail(to: "#{user.displayed_name} <#{user.email}>" , subject: "Welcome!")  do |format|
      format.html
    end
  end

  def password_reset(user, newPassword)
    @user = user
    @login_url = sign_in_url
    @password = newPassword
    mail(to: "#{user.displayed_name} <#{user.email}>" , subject: "Password reset")  do |format|
      format.html
    end
  end
  
  def invite(user, email, message)
    @user = user
    @start_url = root_url
    @message = message
    
    mail(to: email , subject: "Inviation to BOOGif")  do |format|
      format.html
    end
  end


end
