module ApplicationHelper

  def redirect_from_param(default)
    redirect_path = params[:redirect_path]
    if redirect_path
      redirect_to redirect_path
    else
      redirect_to default
    end
  end

end
