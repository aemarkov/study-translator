var pageInitialized=false;
$(document).ready(function() {
	
	//twice document.ready call fix
	if(pageInitialized) return;
    pageInitialized = true;
	
	//Animate anchors
	$('a[href^="#"]').click(function () { 
	    elementClick = $(this).attr("href");
	    destination = $(elementClick).offset().top;    
	    $('html, body').animate( { scrollTop: destination }, 300 );
	    return false;
   	});

	
	//Send code to server button event
	$('#btnSend').click(function() {
		var textBox=$('#textSurce');
		var text=textBox.val();
		$.get("translate", {sourcecode: text}, onAjaxSuccess);
	});
	
	function onAjaxSuccess(data)
	{
		$('#textDestination').val(data);
	}
});