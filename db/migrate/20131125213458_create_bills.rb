class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.boolean :negative, :default => true
      t.string :comment
      t.integer :amount, :default => 0
      t.string :ref

      t.timestamps
    end
    add_index :bills, [:user_id, :created_at]
  end
end
