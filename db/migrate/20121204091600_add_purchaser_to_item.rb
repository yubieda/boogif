class AddPurchaserToItem < ActiveRecord::Migration
  def change
    add_column :items, :purchaser_id, :integer
  end
end
