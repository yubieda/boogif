class Event < ActiveRecord::Base
  attr_accessible :day, :name
  belongs_to :owner, class_name: "User", primary_key: "id", foreign_key: "owner_id"  
  has_many :invitees, dependent: :destroy
  accepts_nested_attributes_for :invitees, allow_destroy: true

  def invited_people
    invitees.map {|i| User.find_by_id(i.user_id)}
  end
  
end
