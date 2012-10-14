module UsersHelper

  def get_item_rows(user)
    items_per_row = 6
    user.items.each_slice(items_per_row)
  end
  
end
