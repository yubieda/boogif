class Connection < ActiveRecord::Base
  attr_accessible :connection_type_id, :to_id
  
  belongs_to :from, class_name: "User", primary_key: "id", foreign_key: "from_id"
  belongs_to :to, class_name: "User", primary_key: "id", foreign_key: "to_id"
  has_one :connection_type

  def confirm!
    self.confirmed = 1
    self.save
  end
end
