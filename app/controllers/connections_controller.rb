class ConnectionsController < ApplicationController
  before_filter :redirect_if_not_signed_in

  def create
    current_user.connect!(User.find(params[:user_id]))
    UserMailer.connection_request(current_user, User.find_by_id(params[:user_id])).deliver

    flash[:success] = "Connection request has been sent"
    redirect_back_or(profile_connections_path)
  end
  
  def delete
    current_user.disconnect! User.find(params[:user_id])
    redirect_back_or(profile_connections_path)
  end
  
  # TODO:
  # move to model
  def confirm
    other_user = User.find(params[:user_id]) 
    c = other_user.connections.find_by_to_id(current_user.id)
    c.confirm!
    UserMailer.connection_confirmation(other_user, current_user).deliver
    
    # other way connection
    c2 = current_user.connect!(other_user, true)
    c2.confirm!
    flash[:success] = "Connection confirmed"

    redirect_back_or(profile_connections_path)
  end

end
