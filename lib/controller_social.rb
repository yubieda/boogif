# This module defines all social elements

module ControllerSocial
  
  def post_to_fb_feed user, message
    oauth_token = user.oauth_token
    if oauth_token
      @graph = Koala::Facebook::API.new(oauth_token)
      options = {
        :message => message,
        :name=> "BOOGiF - The Right Gift, The Easy Way!",
        :picture => 'http://www.boogif.com/assets/BG128x128.png',
        :link => "http://www.boogif.com",
        :description=>"Do you want to find the right gift and always receive what you want?"
      }
      @graph.put_connections("me", "feed", options)
    end
  end
end