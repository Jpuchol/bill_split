class Group < ActiveRecord::Base
  belongs_to :user
  has_many :members, foreign_key: "group_id", dependent: :destroy
  has_many :users, through: :members, source: :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :name,    presence: true, length: { minimum: 5, maximum: 50 }
  validates :comment, presence: true

  def member?(other_user)
    members.find_by(user_id: other_user.id)
  end

  def member!(other_user)
    members.create!(user_id: other_user.id)
  end

  def unmember!(other_user)
    members.find_by(user_id: other_user.id).destroy!
  end
end
