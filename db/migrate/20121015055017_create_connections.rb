class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :connection_type_id
      t.boolean :confirmed

      t.timestamps
    end
    add_index :connections, :from_id
    add_index :connections, :to_id
    add_index :connections, [:from_id, :to_id], unique: true
    
  end
end
