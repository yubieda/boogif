class UsersController < ApplicationController
  include UsersHelper
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      UserMailer.account_confirmation(@user).deliver
      redirect_from_param(@user)
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])    
    @post = @user.user_posts.build if signed_in?
    @item_rows = get_item_rows(@user)
  end

  def edit
    redirect_if_not_signed_in
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      cookies.permanent[:remember_token] = @user.remember_token      
      redirect_to @user
    else
      render 'edit'
    end
  end

  def reset_password
    @user = User.find_by_email(params[:email])
    @email = params[:email]
    
    if @user
      newPassword = @user.reset_password!
      UserMailer.password_reset(@user, newPassword).deliver      
      flash[:success] = "An email has been sent to " + @user.email + " with a temporary password."
      redirect_to sign_in_path
    else
      @user = User.new
      if @email 
        flash[:error] ="Sorry, we don't recognize that email address"
      end
    end
  end


end
