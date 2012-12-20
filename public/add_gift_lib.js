function hostname() {
    return "http://warm-crag-9504.herokuapp.com/"
    //return "http://localhost:3000/"
}

function jqueryLocation() {
    return 'http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
    //return hostname() + "jquery.min.js"
}

function jqueryUiLocation() {
    return 'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js'
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
	$(this).height() > 30 &&
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


function loadCssFile(cssLocation, callback) {
    $.ajax({
	url: cssLocation,
	dataType: 'css',
	success: function(){
	    $('<link rel="stylesheet" type="text/css" href="' + cssLocation + '" />').appendTo("head");
	    callback;
	}
    });
}

function getTextInput(name, value) {
    return '<input name="' + name + '" type="text" value="' + value + '" ><br/>' 
}

function getImageInputButton(name) {
    return '<input name="item[photo_path]" type="radio" value="' + name +'"><img style="max-height: 50px; max-width: 100px;" src="' + name + '"><br/><br/>';
}


function addPopup(title, price, description) {

    var popupClass = '.boogif-add-gift';
    
    if ($(popupClass).length > 0)
    {
	$(popupClass).fadeIn('slow');
    	return;
    }
    
    popup = $(document.createElement('div'));
    header = $(document.createElement('div'));
    form = $(document.createElement('form'));
    logo = $(document.createElement('img'));
    imgHolder = $(document.createElement('div'));
    signal = $(document.createElement('span'));
        
    popup.append(header);
    popup.append(logo);
    popup.append(form);
    popup.addClass('boogif-add-gift');
        
    header.append('<b>Add a gift!</b>');
    
    exit = $('<span class="boogif-add-gift-exit">X</span>');
    
    exit.css('float', 'right');
    exit.css('display', 'block');
    exit.css('color', 'red');
    exit.click(function() { popup.fadeOut('slow');});
    header.append(exit);
    
    header.css('background','lightblue');
    header.css('border-bottom', '1px solid grey');
    
    form.append('<label>Product Name:</label><br>');
    form.append(getTextInput('item[title]', title));
    form.append('<label>Price:</label><br>');
    form.append(getTextInput('item[price]', price));
    form.append('<label>Description:</label><br>');
    form.append(getTextInput('item[description]', description));
    form.append('<label>Image:</label><br>');
    form.append('<input type="hidden" name="item[buy_link]" value ="' +
		document.location.href + '">');

    
    form.attr('accept-charset', 'UTF-8');
    form.attr('action', hostname() + '/items');
    form.id = 'new_item';
    form.attr('method','post');

    logo.attr('src', hostname() + "/assets/logo.png");
    
    popup.css('position', 'absolute');
    popup.css('background', 'white');
    popup.css('color', 'black');
    popup.css('width', '320px');
    popup.css('right', '10px');
    popup.css('top', '10px');
    popup.css('display', 'block');
    popup.css('border', '3px solid grey');
    popup.css('z-index', '9999999');
        
    form.append('<br/>');
    var imgs = getImageNames();
    for (var i=0;i<imgs.length;i++)
    {
	console.log(imgs[i]);
	imgHolder.append( getImageInputButton(imgs[i]));	
    }
    imgHolder.css('width','320px');
    imgHolder.css('overflow-x','auto');
    imgHolder.css('overflow-y','auto');
    imgHolder.css('height','120px');
    imgHolder.css('position','static');
    
    
    form.append(imgHolder);
    form.append('<input name="commit" type="submit" value="Add To My Book">');    
    
    $('body').append(popup);
 
    return;
}

function giftAdder(title, price, description) {
    loadJquery(function(){
	jQuery.getScript(hostname() + "popup.js?body=1", addPopup(title,price,description));
	jQuery.getScript(jqueryUiLocation(), function(){popup.draggable();});
    });
}

function giftAdderGeneric() {
    giftAdder('','','');
}


//loadJquery(function(){giftAdder();});


