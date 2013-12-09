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

	def unmember!(id_to_del)
		members.find_by(id: id_to_del).destroy!
	end

	def self.from_which_i_am_a_member(user)
    	where("id IN (SELECT group_id FROM members WHERE user_id = :current_user_id) ",current_user_id: user.id)
	end
end
