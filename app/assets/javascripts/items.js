$(function(){
    $('.item-image-and-title').click(function() {
	displayPopup($(this).siblings().find('.item-dialog-pop'));
    });
    
    $('.popup-exit').click(function() {
        exitPopup();
    });
    
});

