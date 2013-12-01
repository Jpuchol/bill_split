class Group < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :name,    presence: true, length: { minimum: 5, maximum: 50 }
  validates :comment, presence: true
end
