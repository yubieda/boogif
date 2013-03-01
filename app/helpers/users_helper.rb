module UsersHelper

  def get_item_rows(user)
    items_per_row = 6
    items = user.items
    if(user != current_user) 
      items.select! { |i| i.purchaser_id == nil || i.purchaser_id == current_user.id }
    end
    items.each_slice(items_per_row)
  end
  
  def display_profile_pic user, size
    photo_url = user.photo.url(size)
    puts "\n\n\n#{photo_url}\n\n\n"
    if photo_url == "profile_missing_#{size}.png"
      return (user.male?)?image_path("avatar1.png"):image_path("avatar2.png")
    end
    return photo_url
  end
  
end
