class Bill < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :comment,      presence: true, length: { maximum: 50 }
  validates :user_id,      presence: true
  validates :amount_cents, presence: true


  monetize :amount_cents

end
