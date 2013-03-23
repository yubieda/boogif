class ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :redirect_if_not_signed_in
  #  before_filter :redirect_if_not_signed_in
  include ItemsHelper

  def create
    params[:item][:price] = params[:item][:price].to_f.to_s
    @item = current_user.items.build(params[:item])
    fix_item_currency
    
    if @item.save
      post_to_fb_feed current_user, "I have added a new product to BOOGiF, the social gift registry that helps to create and share easily a list of things you like and want.", "added_product_BG"
      render :action => 'create'
    else
      @images = [@item.photo_path].compact
      flash[:error] = "Failed to add item"
      render :action => 'new'
    end
  end

  def new 
    @item = Item.new    
  end

  def destroy 
    @item = current_user.items.find_by_id(params[:id])
    if @item
      @item.destroy
    end
    redirect_to current_user
  end  

  def update
    @item = current_user.items.find_by_id(params[:id])
    if @item && @item.update_attributes(params[:item])
      fix_item_currency
      @item.save
      flash[:sucess] = "Item updated"
      redirect_to current_user
    else
      create
    end
  end

  def purchase
    @item = Item.find(params[:id])
    if !(@item.user.connected?(current_user))
      flash[:error] = "You're not connected!"
      redirect_to current_user
    end
    @item.purchaser_id = current_user.id
    @item.save
    UserMailer.gift_reminder(current_user, @item).deliver
    render :text => "OK"
  end

  def unpurchase
    @item = Item.find(params[:id])
    if !(@item.purchaser == current_user)
      flash[:error] = "You're not buying this item"
      redirect_to current_user
    end
    @item.purchaser_id = nil
    @item.save
    render :text => "OK"
  end




end
