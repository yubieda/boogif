$(function(){
    $('.item-image-and-title').click(function() {
	displayPopupAndFrame($(this).siblings().find('.item-dialog-pop'));
    });
    
    $('.popup-exit').click(function() {
        exitPopup('.popup-frame');
    });

    $('.add-gift-exit').click(function() {
	parent.location = parent.location;
	//parent.exitPopup('.add-gift');
	
	//alert($('.add-gift').length);
	//$('.add-gift-div').css('color','red');
	//$('h1').css('color','red');
	//$('.add-gift').fadeOut();
//	alert('hello');
//	window.close();
	
	//window.close();
//	$('add-gift').fadeOut();
    });
    
});

