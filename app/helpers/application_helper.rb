module ApplicationHelper

  def redirect_from_param(default)
    redirect_path = params[:redirect_path]
    if redirect_path
      redirect_to redirect_path
    else
      redirect_to default
    end
  end


  def bookmarklet_code
    "javascript:(function(){try{var x=document.getElementsByTagName('head').item(0);var o=document.createElement('script');if('object'!=typeof(o)){o=document.standardCreateElement('script');}o.setAttribute('src','#{APP_PUBLIC_URL}/assets/add_gift.js');o.setAttribute('type','text/javascript');x.appendChild(o);}catch(e){alert('Error: '+e);}})();"
  end
end
