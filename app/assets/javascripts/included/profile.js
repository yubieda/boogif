$(function() {

    var links = $('.disconnect-link');
        
    for (i=0;i<links.length;i++)
    {
	//links[i].click(function () { alert('test'); });
	// link.href = "";
	links[i].onClick = function() {
	    var confirmed = confirm('Are you sure you want to disconnect from this user?');
	    if(confirmed) {
	 	window.location = "http://www.google.com"
	     }
	};
    }
});