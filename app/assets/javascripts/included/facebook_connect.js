$(function(){
    $('.facebook-message').click(function() {
	$('body').append('<div id="fb-root"></div>');
	window.fbAsyncInit = function() {
	    FB.init({appId: '387775747964012', status: true, cookie: true, xfbml: true});
	};

	$.getScript(document.location.protocol + '//connect.facebook.net/en_US/all.js', function() {

	    FB.ui({
		method: 'send',
		name: 'BOOGiF - The right gift, the easy way',
		link: 'http://warm-crag-9574.herokuapp.com/'
	    });
	});

	    
    });
});

