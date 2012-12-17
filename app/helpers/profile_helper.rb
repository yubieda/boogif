module ProfileHelper

  def active?(page_name)
    "active-nav" if params[:action] == page_name
  end

end
