class ProfileController < ApplicationController
  def connections
    @search_string = params[:search].downcase
    
    @searched_users = []

    if @search_string
    #opportunity for optimization
      @searched_users = User.all.select { |u| 
        u.id != current_user.id && 
        (u.first_name.downcase.include?(@search_string) || 
        u.last_name.downcase.include?(@search_string) || 
        u.displayed_name.downcase.include?(@search_string)) }
    end
  end
  def reminders
  end
end
