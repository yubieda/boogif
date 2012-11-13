class ConnectionsController < ApplicationController
  before_filter :redirect_if_not_signed_in

  def create
    current_user.connect!(User.find_by_id(params[:user_id]))
    flash[:success] = "Requested connection"
    redirect_back_or(profile_connections_path)
  end
  
  def destroy
    cs = current_user.connections.select{|c| c.to_id = params[:user_id]}
    other_user = User.find_by_id(params[:user_id])

    if cs.length >= 1
      cs.first.delete
    end
    cs2 = other_user.connections.select{|c| c.to_id = current_user.id}
    
    if cs2.length >= 1
      cs2.first.delete
    end

  end

  def confirm
    other_user = User.find_by_id(params[:user_id]) 
    c = other_user.connections.find_by_to_id(current_user.id)
    c.confirm!
    # other way connection
    c2 = current_user.connect!(other_user)
    c2.confirm!
    flash[:success] = "Connection confirmed"

    redirect_back_or(profile_connections_path)
  end

end
