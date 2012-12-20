class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :email, 
  :male, :birthday, :hide_age, :street_address, :hide_address, :city, :country, :zip_code, :photo, :password, :password_confirmation 
  has_secure_password
  has_many :user_posts, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :connections, foreign_key: "from_id", dependent: :destroy
  has_many :events, foreign_key: "owner_id", dependent: :destroy
  
  has_attached_file :photo,
  :styles => {
    :thumb=>"100x100#", 
    :small=>"200x200#" }, 
  :default_url => "profile_missing_:style.png"

  def connect!(other_user)
    to_id = other_user.id
    from_id = self.id
    c = connections.new(to_id: to_id, connection_type_id: 1)
    c.from_id = from_id
    c.confirmed = 0
    UserMailer.connection_request(self, other_user).deliver
    if self.connections.select{|c| c.to_id==to_id}.length == 1
      c.save
    end
    c
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
    bday = self.birthday.day.to_s + "/" + self.birthday.month.to_s
    if !self.hide_age
      bday += "/" + self.birthday.year.to_s
    end
    bday
  end

  def display_address
    addr = ""
    if !self.hide_address && self.street_address
      addr += self.street_address
    end
    if self.city 
      addr += ", " + self.city
    end
    if self.country 
      addr += ", " + self.country
    end
    addr
  end

  def connected?(other_user)
    connected_people.include?(other_user)
  end

  def invited_events
    invitedEvents = Invitee.find_all_by_user_id(id) || []
    invitedEvents.map {|i| i.event}
  end

  def connected_people
    connections.select {|c| c.confirmed}.map { |c| User.find_by_id(c.to_id) } 
  end
  
  def requested_connections
    Connection.all.select {|c| !(c.confirmed) && c.to_id==self.id}.map{|c| User.find_by_id(c.from_id)}
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
  validates :email, presence: true, uniqueness: true, length: { maximum: 75 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end


end
