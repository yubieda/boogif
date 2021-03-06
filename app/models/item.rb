class Item < ActiveRecord::Base
  attr_accessible :buy_link, :description, :photo_path, :title, :price_cents, :currency, :price, :purchaser_id
  belongs_to :user
  belongs_to :purchaser, class_name: "User", primary_key: "id", foreign_key: "purchaser_id"

  monetize :price_cents

  before_save {
    if !self.price_cents
      self.price_cents = 0
    end
  }
  

  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :description, length: {maximum: 300}

  
  default_scope order: 'items.created_at DESC'


end
