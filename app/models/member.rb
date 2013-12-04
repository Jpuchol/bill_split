class Member < ActiveRecord::Base
  belongs_to :group_id, class_name: "Group"
  belongs_to :user_id,  class_name: "User"
  validates :group_id, presence: true
  validates :user_id,  presence: true

end
