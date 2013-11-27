class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :comment
      t.money :amount, :default => 0
      t.string :ref

      t.timestamps
    end
    add_index :bills, [:user_id, :created_at]
  end
end
