class AddStreetAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :street_address, :string
  end
end
