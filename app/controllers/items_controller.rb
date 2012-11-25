class ItemsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :redirect_if_not_signed_in
  #  before_filter :redirect_if_not_signed_in

  def create
    @item = current_user.items.build(params[:item])
    
    if @item.save
      flash[:success] = "Added Item!"
    else
      flash[:error] = "Failed to add item"
      @item.errors.full_messages.each do |e| 
        flash[:error] += " " + e
      end
    end
    redirect_to current_user
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
      flash[:sucess] = "Item updated"
      redirect_to current_user
    else
      create
    end
  end
end
