class ScrapperController < ApplicationController
  before_filter :redirect_if_not_signed_in, :except => ['scrapped_images']

  def index
    url = session[:referer]
    Rails.logger.debug("Url: #{url}, #{request.env['HTTP_REFERER']}")
    session[:referer] = nil
    @images = get_image_urls(url)

    @item = Item.new :buy_link => url
    render :template => 'items/new'
  end

  def scrapped_images
    session[:scrapped_images] = params[:images]
    render :text => 'OK'
  end

  def redirect_if_not_signed_in
    unless signed_in?
      session[:referer] = request.env['HTTP_REFERER']
      redirect_to sign_in_path :redirect_path => scrapper_path
    end
    # do not set after redirect back from signin
    session[:referer] ||= request.env['HTTP_REFERER']
  end

  def get_image_urls(url)
    sess = Patron::Session.new
    sess.timeout = 10
    sess.default_response_charset = 'utf-8'
    resp = sess.get(url)
    if resp.status < 400
      doc = Nokogiri(resp.body)
      doc.css("img").reject do |img|
        img.attributes['src'].blank? ||
        (img.attributes['style'] && img.attributes['style'].value =~ /display:none/i ) ||
        (img.attributes['width'] && img.attributes['width'].value.to_i < 60) ||
        (img.attributes['height'] && img.attributes['height'].value.to_i < 60)
      end.map{|img| URI.join(url, URI.escape(img.attributes['src'].value)) }
    else
      []
    end
  end
end
