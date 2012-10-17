class UsersController < ApplicationController
  include UsersHelper
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
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
      redirect_to @user
    else
      render 'edit'
    end
  end

end
