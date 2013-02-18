module SessionsHelper

  def sign_in(user, remember_me = false)
    cookie_data = { :value => user.remember_token }
    cookie_data.merge!(:expires => 2.weeks.from_now) if remember_me
    cookies[:remember_token] = cookie_data

    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_if_not_signed_in
    unless signed_in?
      redirect_to sign_in_path
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url
  end

end
