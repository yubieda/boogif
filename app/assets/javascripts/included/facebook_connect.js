$(function(){
  $('body').append('<div id="fb-root"></div>');
  window.fbAsyncInit = function() {
    FB.init({appId: '164587797025249', status: true, cookie: true, xfbml: true});
  };
  $.getScript(document.location.protocol + '//connect.facebook.net/en_US/all.js');

  $('.facebook-message').click(function() {
      FB.ui({
        method: 'send',
        name: 'BOOGiF - The Right Gift, The Easy Way!',
        link: 'http://warm-crag-9574.herokuapp.com/',
        description: (
        	'Do you want to find the right gift and always receive what you want?<br/>'+
			'Then, BOOGiF is the solution you need.<br/>'+
			  '*Find the right gift for someone special in a few seconds.<br/>'+
			  '*And make others always give you the things you love.</br/>'+
			'Join today at www.boogif.com'
	   ),
	   picture: 'http://warm-crag-9574.herokuapp.com/assets/BG128x128.png'
      });
    return false;
  });
});

