# -*- coding: utf-8 -*-
module ItemsHelper

  def fix_item_currency
    priceString = params[:item][:price]
    
    if priceString.include? '€'
      @item.currency = 'EUR'
    elsif priceString.include? '¥'
      @item.currency = 'JPY'
    
    end
    
  end
  
  def item_photo_path item
    return (item.photo_path.nil?)?image_path("no-image-found.jpg"):item.photo_path
  end

end
