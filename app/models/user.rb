require 'file_size_validator'
class User < ActiveRecord::Base
  has_many :bills,  dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :members,    foreign_key: "user_id", dependent: :destroy
  has_many :bill_users, foreign_key: "user_id", dependent: :destroy
  has_many :temps,      foreign_key: "user_id"
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  STR_REGEX = /\A[a-z0-9\-]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :imag, PictureUploader
  validates :imag, :file_size => { :maximum => 2.megabytes.to_i }
  

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
  #  Bill.where("user_id = ?", id)
    Bill.from_bill_users_by(self)
  end

  def group_feed
    Group.from_which_i_am_a_member(self)
  end
  
  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
