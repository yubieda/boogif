module UsersHelper

  def get_item_rows(user)
    items_per_row = 5
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
  
  def display_address user
    return '' if user.hide_address

    addr_parts = []

    addr_parts.push(user.street_address) if user.street_address.present?
    addr_parts.push(user.city) if user.city.present?
    addr_parts.push(LocalizedCountrySelect::priority_countries_array([user.country])) if user.country.present?
    addr_parts.push(user.zip_code) if user.zip_code.present?

    addr_parts.join(', ')
  end
  
  def display_address_small user
    address = user.city
    country = display_country user.country
    address+= ", #{country}" if country
    return address
  end
  
  def display_country user_country
    LocalizedCountrySelect::priority_countries_array([user_country])[0][0]
  end
  
end
