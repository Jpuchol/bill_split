class CreateBillUsers < ActiveRecord::Migration
  def change
    create_table :bill_users do |t|
      t.integer :bill_id
      t.integer :user_id

      t.timestamps
    end
  end
end
