class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.confirmed
      sign_in(user, params[:session][:remember_me] == "1")
      redirect_from_param(user)
    else
      flash[:error] = 'Invalid email/password combination'
      flash[:error] = 'This account is not yet verified' if (user and !user.confirmed)
      render "new"
      flash.clear()
    end
  end
  
  def fb_create
    user, password = User.from_omniauth(env["omniauth.auth"])
    if user
      UserMailer.facebook_signup_confirmation(user, password).deliver
      sign_in(user, false)
      redirect_from_param(user)
    else
      flash[:error] = 'Cannot initialize with that facebook account'
      render "new"
      flash.clear()
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
