class Event < ActiveRecord::Base
  attr_accessible :day, :name
  belongs_to :owner, class_name: "User", primary_key: "id", foreign_key: "owner_id"  
  
end
