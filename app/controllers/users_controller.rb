class UsersController < ApplicationController
  include UsersHelper
  
  before_filter :redirect_if_not_signed_in, :only => [:show, :edit, :update]
  
  def create
    @user = User.new(params[:user])
    @user.confirmed = false
    @user.generate_confirm_code
    if @user.save
      #sign_in @user
      UserMailer.account_confirmation(@user).deliver
      #redirect_from_param how_to_use_path
      redirect_to root_url, notice: "Your account was created. Please verify your email address to start using BOOGiF (Also check spam folder)"
    else
      render 'new'
    end
  end

  def new
    if signed_in?
      redirect_to root_url
      return
    end
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @post = @user.user_posts.build if signed_in?
    @item_count = @user.items.size
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
  
  def confirm
    user_id = params[:id]
    confirm_code = params[:confirm_code]
    @user = User.find user_id
    if @user.confirm_code == confirm_code
      @user.confirmed = true
      @user.save!
      sign_in @user
      @message = "Your account has been confirmed. Now you can use BOOGiF"
      redirect_to how_to_use_path, notice: @message
    else
      @message = "Invalid verification"
      redirect_to root_url, alert: @message
    end
  end


end
