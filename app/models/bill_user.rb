class BillUser < ActiveRecord::Base
  belongs_to :bill_id, class_name: "Bill"
  belongs_to :user_id, class_name: "User"
  validates :bill_id, presence: true
  validates :user_id, presence: true


end
