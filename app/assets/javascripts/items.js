$(function(){
    $('.add-item-button').click(function() {
	displayPopup($(this).siblings().children('.item-dialog-pop'));
    });
    
    $('.popup-exit').click(function() {
	exitPopup();
    });
    
});

