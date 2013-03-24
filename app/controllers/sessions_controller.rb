class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase) unless params[:session].nil?
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
    oauth = env["omniauth.auth"]
    if User.exists?(:email => oauth.info.email, :provider=>nil)
        redirect_to root_url, :alert=> "You already have a Boogif account with #{oauth.info.email}" 
        return
    end
    user = User.where(:email => oauth.info.email, :provider=>oauth.provider).first
    if user
        user.update_attributes(:oauth_token => oauth["credentials"]["token"])
        sign_in(user, false)
        redirect_to root_url 
        return
    end
  
    user, password = User.from_omniauth(oauth)
    if user
      UserMailer.facebook_signup_confirmation(user, password).deliver
      post_to_fb_feed user, "I have joined to BOOGiF, the social gift registry that helps to find the right gift in a few seconds.", "joined_BG"
      sign_in(user, false)
      #redirect_from_param(user)
      redirect_to how_to_use_path, notice: "Welcome to BOOGiF"
    else
      flash[:error] = 'Cannot initialize with that facebook account'
      render "new"
      flash.clear()
    end
  end

  def destroy
    sign_out
    reset_session
    redirect_to root_url
  end

end
