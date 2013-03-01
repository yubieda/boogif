class UserPostsController < ApplicationController
  before_filter :redirect_if_not_signed_in
    
  def create
    params[:user_post][:content] = process_entry params[:user_post][:content]
    @post = current_user.user_posts.build(params[:user_post])
    
    if @post.save
      flash[:success] = "Created post"
    else
      flash[:error] = "Post should be less 140 symbols"
    end
    redirect_to current_user
  end

  def destroy
    @post = current_user.user_posts.find_by_id(params[:id])
    if @post
      @post.destroy
    end    
    redirect_to current_user
  end
  
end
