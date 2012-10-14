class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :displayed_name, :email, 
  :male, :birthday, :hide_age, :city, :country, :zip_code, :password, :password_confirmation 
  has_secure_password
  has_many :user_posts, dependent: :destroy
  has_many :items, dependent: :destroy
  
  has_attached_file :photo,
  :styles => {
    :thumb=>"100x100#", 
    :small=>"200x200#" }


  before_save { 
    self.email.downcase!
    if self.displayed_name==""
      self.displayed_name = self.first_name + " " + self.last_name
    end        

  }
  
  before_save {
    if !User.find_by_email(self.email)
      create_remember_token
    end
  }
  
  validates :first_name, presence:true, length: { maximum: 40 }
  validates :last_name, presence:true, length: { maximum: 40 }
  validates :male, presence:true
  validates :birthday, presence:true
  validates :email, presence: true, uniqueness: true, length: { maximum: 75 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
