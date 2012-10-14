function post_to_url(url, params) {
    var form = document.createElement('form');
    form.action = url;
    form.method = 'POST';

    for (var i in params) {
	if (params.hasOwnProperty(i)) {
	    var input = document.createElement('input');
	    input.type = 'hidden';
	    input.name = i;
	    input.value = params[i];
	    form.appendChild(input);
	}
    }

    form.submit();
}

function load_jquery() {
    var ref = document.createElement('script');    
    ref.type = 'text/javascript';
    ref.async = true;
    ref.src = 'https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js';
    (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(ref);
}

function submit_amazon_image() {
    var img = jQuery('.main-image-inner-wrapper').find('img').attr('src');
    var title = jQuery('#btAsinTitle').text();
    var buy_link = document.location.href;

    post_to_url("http://localhost:3000/items",{"item[buy_link]":buy_link,
					       "item[description]":"Item from Amazon",
					       "item[photo_path]":img,
					       "item[title]":title});
}

//submit_amazon_image();

//load_jquery()
    //post_to_url("http://localhost:3000/items",{"item[buy_link]":buy_link,  "item[description]":"Item from Amazon","item[photo_path]":img,"item[title]":title})




//post_to_url("http://localhost:3000/user_posts",{"user_post[content]":"teeeeeeeeeest"})
//post_to_url("http://localhost:3000/items",{"item[buy_link]":"http://www.amazon.com",  "item[description]":"test","item[photo_path]":"http://ecx.images-amazon.com/images/I/51EN7cswSYL._SL135_.jpg","item[title]":"KINDLE FIRE"})


