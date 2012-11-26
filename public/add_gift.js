function hostname() {
    return "http://warm-crag-9504.herokuapp.com/"
}


function loadJquery(callback) {
    if(!(window.jQuery && window.jQuery.fn.jquery == '1.3.2'))
    {
	var s = document.createElement('script');
	s.setAttribute('src', 'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js');
	s.setAttribute('type', 'text/javascript');
	document.getElementsByTagName('head')[0].appendChild(s);
	s.onload = callback;
	
    }
}


function loadScript(location) {
    try{
	var x=document.getElementsByTagName('head').item(0);
	var o=document.createElement('script');
	if('object'!=typeof(o)){
	    o=document.standardCreateElement('script');
	}
	o.setAttribute('src',location);
	o.setAttribute('type','text/javascript');
		
	x.appendChild(o);
    }catch(e){
	alert('Error: '+e);
    }
}

function imageFilter(index) {
    var imgName = $(this).attr('src');
        
    return $(this).css('display') != 'none' &&
	$(this).height() > 50 &&
	imgName.charAt(imgName.length-1) != 'f';
}


function getImageNames() {
    return $('img').filter(imageFilter).map(function() { return $(this).attr('src') });
}

function getImageNameQueryString() {
    return getImageNames().get().reduce(function(p, n, index, array) {
	return p + 'test[]=' + n + '&';
    }, '');
}

function addGiftUrl() {
    //return "http://www.amazon.com";
    return hostname() + "add_gift?" + getImageNameQueryString();
}



function addPopup() {
    $('body').append('<div class="add-gift"> </div>');
    var popup = $('.add-gift');

    popup.append('<div class="add-gift-exit">X</div>');

    
    popup.append('<iframe src="' + addGiftUrl() + '" class="add-gift-frame"><b>Add a gift!</b></iframe>');
    var frame = $('.add-gift-frame');
    
    frame.css('height','400px');
    
    popup.css('display','none');
    popup.css('background','white');
    popup.css('border','3px solid grey');
    
    exit = $('.add-gift-exit');
    exit.css('float','right');
    exit.css('color','red');
    exit.click(function() {parent.exitPopup('.add-gift');});
    

    displayPopup(popup);
}


loadJquery(jQuery.getScript(hostname + "popup.js",addPopup));


