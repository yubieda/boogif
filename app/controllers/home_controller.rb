class HomeController < ApplicationController
  def home
    redirect_to user_path(current_user) if current_user
  end
end
