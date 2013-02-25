class User < ActiveRecord::Base
  paginates_per 50
  
  attr_accessible :email, :first_name, :last_name, :email, 
  :male, :birthday, :hide_age, :street_address, :hide_address, :city, :country, :zip_code, :photo, :password, :password_confirmation 
  has_secure_password
  has_many :user_posts, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :connections, foreign_key: "from_id", dependent: :destroy
  has_many :to_connections, class_name: 'Connection', foreign_key: "to_id", dependent: :destroy
  has_many :events, foreign_key: "owner_id", dependent: :destroy
  

  has_attached_file :photo,
  :styles => {
    :thumb=>"100x100#", 
    :small=>"200x200#" }, 
  :default_url => "profile_missing_:style.png"

  def connect!(other_user, confirmed = false)
    c = self.connections.new(to_id: other_user.id, connection_type_id: 1)
    c.confirmed = confirmed
    c.save!
    c
  end

  def disconnect!(other_user)
    self.connections.where(to_id: other_user.id).delete_all
    other_user.connections.where(to_id: self.id).delete_all
  end

  def reset_password!
    self.password = SecureRandom.hex(3)
    self.password_confirmation = self.password
    create_remember_token
    self.save!
    self.password
  end    
  
  def full_name 
    self.first_name + " " + self.last_name
  end

  def display_birthday
    bday = self.birthday.strftime("%B") + " " + self.birthday.day.to_s
    if !self.hide_age
      bday += ", " + self.birthday.year.to_s
    end
    bday
  end

  def display_address
    return '' if self.hide_address

    addr_parts = []

    addr_parts.push(self.street_address) if self.street_address.present?
    addr_parts.push(self.city) if self.city.present?
    addr_parts.push(self.country) if self.country.present?
    addr_parts.push(self.zip_code) if self.country.present?

    addr_parts.join(', ')
  end

  def connected?(other_user)
    connections.confirmed.where(:to_id => other_user.id).count > 0
  end

  def invited_events
    invitedEvents = Invitee.find_all_by_user_id(id) || []
    invitedEvents.map {|i| i.event}
  end

  def connected_people
    connections.confirmed.map(&:to)
  end
  

  def requested_connections
    self.to_connections.unconfirmed.map(&:from)
  end

  before_save { 
    self.email.downcase!
  }
  
  before_save {
    if !User.find_by_email(self.email)
      create_remember_token
    end
  }

  validates :first_name, presence:true, length: { maximum: 40 }
  validates :last_name, presence:true, length: { maximum: 40 }
  validates_inclusion_of :male, in: [true, false]
  validates :birthday, presence:true
  validates :email, presence: true, uniqueness: true, email_format: {message: 'is invalid' }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :city, presence: true
  validates :country, presence: true

    
  def generate_confirm_code
    self.confirm_code = SecureRandom.urlsafe_base64
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
