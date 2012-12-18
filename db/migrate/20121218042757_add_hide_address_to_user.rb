class AddHideAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :hide_address, :bool
  end
end
