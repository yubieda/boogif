require "browser"
class ProfileController < ApplicationController
  before_filter :redirect_if_not_signed_in
  
  # TODO:
  # - split into two methods
  # - refactor
  def connections
    @search_string = params[:search]
    @mutual_user_id = params[:mutual_user_id]
    
    @searched_users = []
    @mutual_users = []

    if @search_string
      @search_string.downcase!
      #opportunity for optimization
      search_query = "%#{@search_string}%"
      @searched_users = User.
        where("first_name ilike ? OR last_name ilike ?", search_query, search_query).
        where("id != ?", current_user.id).all
    end

    #mutual connections.  Could probably optimize as well
    if @mutual_user_id
      @other_user = User.find_by_id(@mutual_user_id) 
      my_connections = current_user.connections.confirmed
      other_connections = []      
      if @other_user 
        other_connections = @other_user.connections.confirmed
      end
      
      for c in my_connections
        mutual_connection = other_connections.select { |oc| 
          oc.to_id == c.to_id }.first
        if mutual_connection
          @mutual_users.push(User.find_by_id(mutual_connection.to_id))
        end
        mutual_connection = nil
      end
    end
    

    store_location
  end


  def invites
    @emailsParam = params[:emails]
    @is_mobile = browser.mobile?
    
    if @emailsParam
      @emails = params[:emails].split(',')
      @message = params[:message]
      for @email in @emails 
        UserMailer.invite(current_user, @email, @message).deliver 
        flash[:success] = "Invites sent"
      end
      redirect_to profile_invites_path(params: {})
    end
  end

  
end
