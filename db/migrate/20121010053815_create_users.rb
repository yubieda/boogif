class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :displayed_name
      t.string :email
      t.boolean :male
      t.date :birthday
      t.boolean :hide_age
      t.string :city
      t.string :country
      t.string :zip_code      
      t.string :password_digest
      t.string :remember_token
      #photo data file info for paperclip
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size

      t.timestamps
    end
  end
end
