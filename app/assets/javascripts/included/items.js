$(function(){
    $('.item-image-and-title').click(function() {
	displayPopupAndFrame($(this).siblings().find('.item-dialog-pop'));
    });
    
    $('.popup-exit').click(function() {
        exitPopup('.popup-frame');
    });

    $('.purchase').change(function() {
	if(this.checked) {
	    alert("We'll hide this item from other friends, to avoid repeat gifts!");
	    $.ajax(add_query_string_param("/purchase_item","id",this.id));
	}
	else {
	    alert("We'll start showing this to other friends, so someone else can buy it!");
	    $.ajax(add_query_string_param("/unpurchase_item","id",this.id));
	}
		
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

