function add_query_string_param(url, key, value) {
    
    if(url.indexOf("?") == -1) {
	url += "?";
    }
    else {
	url += "&";
    }

    return url + key + "=" + value;    
}

(function($){
    $(window).resize(function(){
    	if($(window).width() < 763){
    		$(".variable-container").css("margin-top", "63px");
    	}else{
    		$(".variable-container").css("margin-top", "83px");
    	}
    });
})(jQuery);