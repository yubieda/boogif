$(function(){
  wrapPopup('.popup-frame','.popup')
});

function dynamicCenter(item) {
  var windowW = $(window).width();// document.documentElement.clientWidth;
  var windowH = $(window).height(); //document.documentElement.clientHeight;
  var popupH = $(item).height();
  var popupW = $(item).width();
  $(item).css('position', 'absolute');
  $(item).css('top', $(item).offset().top + windowH/2-popupH/2);
  $(item).css('left', windowW/2-popupW/2);
  return item;
}

function displayPopupAndFrame(item) {
  $('.popup-background').fadeIn('slow');
  var frame = $(item).parents('.popup-frame');
  dynamicCenter(frame);
  frame.fadeIn('slow');
}

function displayPopup(item) {
  dynamicCenter(item);
  item.fadeIn('slow');    
}



//manipulate DOM to wrap popup in frame and background
function wrapPopup(frame, popup) {
  $(popup).wrap($(frame));
}

function exitPopup(selector) {
  $('.popup-background').fadeOut('slow');
  $(selector).fadeOut('slow');
  //    $('.popup-frame').fadeOut('slow');

  //$(item).parents('.popup-frame').fadeToggle('slow');
}

