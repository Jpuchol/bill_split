require 'file_size_validator' 
class Bill < ActiveRecord::Base
  belongs_to :user
  has_many :bill_users, foreign_key: "bill_id", dependent: :destroy
  has_many :temps, foreign_key: "bill_id"
  accepts_nested_attributes_for :bill_users
  default_scope -> { order('created_at DESC') }
  validates :comment,      presence: true, length: { maximum: 50 }
  validates :user_id,      presence: true
  validates :amount, presence: true
  mount_uploader :ref, BillUploader
  validates :ref, :file_size => { :maximum => 2.megabytes.to_i }
  

  def groups?(user)
    bill_users.find_by(user_id: user.id)
  end

  def user!(user,bill)
    sql = 'INSERT INTO bill_users ("bill_id","user_id") VALUES (#{(bill.id).to_s}","#{user.id).to_s})'
    records_array = ActiveRecord::Base.connection.execute(sql)
  end


  def self.from_bill_users_by(user)
    bill_user_ids = "SELECT bill_id FROM bill_users
                       WHERE user_id = :user_id"
    where("id IN (#{bill_user_ids})", user_id: user.id)
  end

end
