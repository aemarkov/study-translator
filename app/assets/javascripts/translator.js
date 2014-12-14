//var pageInitialized=false;

$(document).ready(function() {

	//twice document.ready call fix
	//if(pageInitialized) return;
    //pageInitialized = true;

    resize();

	//Send code to server button event
	$('#btnSend').click(function() {
		var textBox=$('#sourceCode');
		var text=textBox.val();
		$.get("translate", {sourcecode: text}, onAjaxSuccess);
	});
	
	//Code editors resize
	$(window).resize(function(){
		setTimeout(resize(),10);
	});



	function resize()
	{
		//alert('resize');
		var width=$('html').width()/2-2;
		var height=$('html').height()-275;
		$('.code-editor').css({'width':width+'px'});
		$('.code-editor').css({'height':height+'px'});

		width=width-25;
		height=height-70;
		$('#sourceCode').css({'width':width+'px'});
		$('#destinCode').css({'width':width+'px'});
		$('#sourceCode').css({'height':height+'px'});
		$('#destinCode').css({'height':height+'px'});
	}

	//Receiving code from server
	function onAjaxSuccess(data)
	{
		$('#destinCode').val(data);
	}
});