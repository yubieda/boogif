class RemoveDisplayedNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :displayed_name
  end

  def down
    add_column :users, :displayed_name, :string
  end
end
