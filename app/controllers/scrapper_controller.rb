class ScrapperController < ApplicationController
  before_filter :redirect_if_not_signed_in, :except => ['scrapped_images']

  def index
    @item = Item.new
    render :template => 'items/new'
  end

  def scrapped_images
    session[:scrapped_images] = params[:images]
    render :text => 'OK'
  end

  def redirect_if_not_signed_in
    unless signed_in?
      redirect_to sign_in_path :redirect_path => scrapper_path
    end
  end
  
end
