class AddConfirmationCodeUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirm_code, :string
    add_column :users, :confirmed, :bool
  end
end
