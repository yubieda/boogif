
$(function(){
    wrapPopup('.popup-frame','.popup')
    
});

function dynamicCenter(item) {
    var windowW = document.documentElement.clientWidth;
    var windowH = document.documentElement.clientHeight;
    var popupH = $(item).height();
    var popupW = $(item).width();
    $(item).css('position', 'absolute');
    $(item).css('top', windowH/2-popupH/2);
    $(item).css('left', windowW/2-popupW/2);
}

function displayPopup(item) {
    $('.popup-background').fadeIn('slow');
    var frame = $(item).parents('.popup-frame');
    dynamicCenter(frame);
    frame.fadeIn('slow');

}

//manipulate DOM to wrap popup in frame and background
function wrapPopup(frame, popup) {
    $(popup).wrap($(frame));
}

function exitPopup() {
    $('.popup-background').fadeOut('slow');
    $('.popup-frame').fadeOut('slow');

    //$(item).parents('.popup-frame').fadeToggle('slow');

}

