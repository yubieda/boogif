class ScrapperController < ApplicationController
  before_filter :redirect_if_not_signed_in, :except => ['scrapped_images']

  def index
    url = request.env['HTTP_REFERER']

    sess = Patron::Session.new
    sess.timeout = 10
    sess.default_response_charset = 'utf-8'
    resp = sess.get(url)

    if resp.status < 400
      doc = Nokogiri(resp.body)
    end

    @images = doc.css("img").map{|img| img.attributes['src'].value }
    @item = Item.new :buy_link => url
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
