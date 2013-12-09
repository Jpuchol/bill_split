class Member < ActiveRecord::Base
  belongs_to :group, class_name: "Group"
  belongs_to :user,  class_name: "User"
  validates :group_id, presence: true
  validates :user_id,  presence: true


end
