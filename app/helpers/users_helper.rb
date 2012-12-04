module UsersHelper

  def get_item_rows(user)
    items_per_row = 6
    items = user.items
    if(user != current_user) 
      items.select! { |i| i.purchaser_id == nil || i.purchaser_id == current_user.id }
    end
    items.each_slice(items_per_row)
  end
  
end
