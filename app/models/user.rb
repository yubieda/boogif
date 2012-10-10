class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { self.email.downcase! }
  before_save {
    if !User.find_by_email(self.email)
      create_remember_token
    end
  }
  
  validates :name, presence:true, length: { maximum: 75 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 75 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
