class CreateBillUsers < ActiveRecord::Migration
  def change
    create_table :bill_users do |t|
      t.integer :bill_id
      t.integer :user_id

      t.timestamps
    end
      add_index :bill_users, :bill_id
      add_index :bill_users, :user_id
      add_index :bill_users, [:bill_id, :user_id], unique: true
  end
end
