class CreateConnectionTypes < ActiveRecord::Migration
  def change
    create_table :connection_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
