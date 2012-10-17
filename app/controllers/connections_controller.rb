class ConnectionsController < ApplicationController
  def create
    current_user.connect!(User.find_by_id(params[:user_id]))
    redirect_to profile_connections_path
  end
  
  def destroy
    
    
  end

  def confirm
    other_user = User.find_by_id(params[:user_id]) 
    c = other_user.connections.find_by_to_id(current_user.id)
    c.confirm!
    # other way connection
    c2 = current_user.connect!(other_user)
    c2.confirm!
    
    redirect_to profile_connections_path
  end

end
