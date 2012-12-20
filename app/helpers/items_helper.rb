# -*- coding: utf-8 -*-
module ItemsHelper

  def fix_item_currency
    priceString = params[:item][:price]
    
    if priceString.include? '€'
      @item.currency = 'EUR'
    elsif priceString.include? '¥'
      @item.currency = 'JPY'
    else
      @item.currency = 'AUS'
    end
    
  end

end
