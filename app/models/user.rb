class User < ActiveRecord::Base
  STR_REGEX = /\A[a-z0-9\-]+\z/i
  validates :name, presence: true, length: { minimum: 6, maximum: 50 },
                    format: { with: STR_REGEX }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
end
