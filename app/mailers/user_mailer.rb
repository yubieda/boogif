class UserMailer < ActionMailer::Base
  
  default from: "BOOGiF Support <support@boogif.com>"
  
  def account_confirmation(user)
    @user = user
    @root_url = root_url
    @verification_url = email_confirmation_url({:id=> @user.id, :confirm_code=>@user.confirm_code})
    @help_url = how_to_use_url
    mail(to: "#{user.full_name} <#{user.email}>" , subject: "Welcome!")  do |format|
      format.html
    end
  end
  
  def facebook_signup_confirmation(user, password)
    @user = user
    @password = password
    @root_url = root_url
    @help_url = how_to_use_url
    mail(to: "#{user.full_name} <#{user.email}>" , subject: "Welcome!")  do |format|
      format.html
    end
  end

  def password_reset(user, newPassword)
    @user = user
    @login_url = sign_in_url
    @password = newPassword
    mail(to: "#{user.full_name} <#{user.email}>" , subject: "Password reset")  do |format|
      format.html
    end
  end
  
  def invite(user, email, message)
    @user = user
    @start_url = root_url
    @message = message
    
    mail(to: email , subject: user.first_name + " wants to buy you a gift")  do |format|
      format.html
    end
  end

  def gift_reminder(user, item)
    @user = user
    @other_user = item.user
    @item = item
    mail(to: "#{user.full_name} <#{user.email}>" , subject: "Gift reminder")  do |format|
      format.html
    end    
  end

  def connection_request(from_user, to_user)
    @from_user = from_user
    @to_user = to_user
    @connect_url = profile_connections_url
    mail(to: "#{to_user.full_name} <#{to_user.email}>" , subject: "Connection Request")  do |format|
      format.html
    end
  end

  def connection_confirmation(from_user, to_user)
    @from_user = from_user
    @to_user = to_user
    mail(to: "#{from_user.full_name} <#{from_user.email}>" , subject: "Connection to #{to_user.full_name}")  do |format|
      format.html
    end
  end


end
