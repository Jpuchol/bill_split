class Bill < ActiveRecord::Base
  belongs_to :user
  has_many :bill_users, foreign_key: "bill_id", dependent: :destroy
  accepts_nested_attributes_for :bill_users
  default_scope -> { order('created_at DESC') }
  validates :comment,      presence: true, length: { maximum: 50 }
  validates :user_id,      presence: true
  validates :amount, presence: true

  def groups?(user)
    bill_users.find_by(user_id: user.id)
  end

  def user!(user)
    bill_users.create!(user_id: user.id)
  end


  def self.from_bill_users_by(user)
    bill_user_ids = "SELECT bill_id FROM bill_users
                       WHERE user_id = :user_id"
    where("id IN (#{bill_user_ids})", user_id: user.id)
  end
end
