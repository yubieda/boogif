class UserMailer < ActionMailer::Base
  
  default from: "BOOGif Support <boogifdev@gmail.com>"
  
  def account_confirmation(user)
    @user = user
    @root_url = root_path
    @help_url = root_path 
    mail(to: "#{user.displayed_name} <#{user.email}>" , subject: "Welcome!")  do |format|
      format.html
    end
    
  end


  def password_reset(user, newPassword)
    @user = user
    @login_url = root_path
    @password = newPassword
    mail(to: "#{user.displayed_name} <#{user.email}>" , subject: "Password reset")  do |format|
      format.html
    end
  end
  
  def invite(user, email, message)
    @user = user
    @start_url = root_path
    @message = message
    
    mail(to: email , subject: "Inviation to BOOGif")  do |format|
      format.html
    end
    
    

  end


end
