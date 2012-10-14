class Item < ActiveRecord::Base
  attr_accessible :buy_link, :description, :photo_path, :title
  belongs_to :user
  

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 300}

  
  default_scope order: 'items.created_at DESC'

end
