$(function(){
  $('body').append('<div id="fb-root"></div>');
  window.fbAsyncInit = function() {
    FB.init({appId: '607574899257942', status: true, cookie: true, xfbml: true});
  };
  $.getScript(document.location.protocol + '//connect.facebook.net/en_US/all.js');

  $('.facebook-message').click(function() {
      FB.ui({
        method: 'send',
        name: 'BOOGiF - The Right Gift, The Easy Way!',
        link: 'http://warm-crag-9574.herokuapp.com/'
      });
    return false;
  });
});

