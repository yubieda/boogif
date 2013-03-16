class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  include ControllerShortener
  include ControllerSocial

end
