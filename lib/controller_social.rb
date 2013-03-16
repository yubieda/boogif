# This module defines all social elements

module ControllerSocial
  
  def post_to_fb_feed user, message
    oauth_token = user.oauth_token
    if oauth_token
      @graph = Koala::Facebook::API.new(oauth_token)
      options = {
        :message => message,
        :picture => 'http://warm-crag-9574.herokuapp.com/assets/BG128x128.png',
        :link => "http://warm-crag-9574.herokuapp.com",
        :description=>"Do you want to find the right gift and always receive what you want? www.boogif.com"
      }
      @graph.put_connections("me", "feed", options)
    end
  end
end