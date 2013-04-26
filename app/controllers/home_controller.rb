class HomeController < ApplicationController
  def home
    redirect_to user_path(current_user) if current_user
  end
  
  def join
    if signed_in?
      redirect_to root_url
      return
    end
  end
end
