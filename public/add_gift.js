function hostname() {
    return "http://warm-crag-9504.herokuapp.com/"
    //return "http://localhost:3000/"
}



function jqueryLocation() {
    return 'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
    //return hostname() + "jquery.min.js"
}

function loadJquery(callback) {
    if(!(window.jQuery && window.jQuery.fn.jquery == '1.3.2'))
    {
	var s = document.createElement('script');
	s.setAttribute('src', jqueryLocation());
	s.setAttribute('type', 'text/javascript');
	document.getElementsByTagName('head')[0].appendChild(s);
	s.onload = callback;
    }
    else
    {
	callback.call();
    }
}

//loadJquery( function(){jQuery.getScript(hostname() + "add_gift_lib.js", function(){giftAdderGeneric();});});
loadJquery( function(){jQuery.getScript(hostname() + "add_gift_lib.js", function(){giftAdder('','','');}
				       );});