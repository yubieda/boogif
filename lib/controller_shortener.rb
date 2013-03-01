require 'bitly'
module ControllerShortener
  
  def shortener
    Bitly.new('supportboogif','R_b11314bc3ba8fdacbb988cd2d651c888')
  end
  
  def short_url url
    bitly = shortener
    shorten_url = bitly.shorten(url)
    return shorten_url.short_url
  end
  
  def process_entry entry
    entries = entry.split(" ")
    result = ""
    entries.each do |e|
      e = e.sub(/\b(?:https?:\/\/|www\.)\S+\b/) {|s| process_http_url s}
      result += "#{e} "
    end
    return result
  end
  
  private 
  
  def process_http_url url
    return (short_url url) if url.include? "http"
    return short_url "http://#{url}"
  end
  
end