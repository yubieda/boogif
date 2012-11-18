class ProfileController < ApplicationController
  before_filter :redirect_if_not_signed_in
  
  def connections
    @search_string = params[:search]
    @mutual_user_id = params[:mutual_user_id]
    
    @searched_users = []
    @mutual_users = []

    if @search_string
      @search_string.downcase!
      #opportunity for optimization
      @searched_users = User.all.select { |u| 
        u.id != current_user.id && 
        (u.first_name.downcase.include?(@search_string) || 
         u.last_name.downcase.include?(@search_string) || 
         u.displayed_name.downcase.include?(@search_string)) }
    end

    #mutual connections.  Could probably optimize as well
    if @mutual_user_id
      @other_user = User.find_by_id(@mutual_user_id) 
      my_connections = current_user.connections
      other_connections = []      
      if @other_user 
        other_connections = @other_user.connections 
      end
      
      for c in my_connections
        mutual_connection = other_connections.first { |oc| 
          oc.to_id == c.to_id }
        if mutual_connection
          @mutual_users.push(User.find_by_id(mutual_connection.to_id))
        end
      end
    end
    

    store_location
  end


  def invites
    @email = params[:email]
    @message = params[:message]
    if @email 
      UserMailer.invite(current_user, @email, @message).deliver 
      flash[:success] = "Invite sent"
      redirect_to profile_invites_path(params: {})
    end

    
  end

  
end