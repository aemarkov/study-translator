//var pageInitialized=false;

$(document).ready(function() {

	//twice document.ready call fix
	//if(pageInitialized) return;
    //pageInitialized = true;

	//Menu hiding
	$(window).scroll(function(){
		var pos=$(window).scrollTop();
		if(pos==0)
		{
			$('nav').css({'box-shadow':'none'});	
			
		}
		else
		{
			$('nav').css({'box-shadow':'0 0 5px rgba(0,0,0, 0.7)'});
		}
		
		var header_pos=200;

		if(pos>header_pos)
		{
			$('nav').css({'top':header_pos-pos+'px'});
		}
		else
		{
			$('nav').css({'top':'0px'});
		}

	});

	//Menu type switching
	var windowWidth=$(window).width();
	if(windowWidth<600)
	{
		$('#nav_mobile').css({'display':'inline-block'});
		$('#nav_pc').css({'display':'none'});
	}
	else
	{
		$('#nav_mobile').css({'display':'none'});
		$('#nav_pc').css({'display':'inline-block'});	
	}

	//Mobile menu showing
	$('#btnMenu').click(function(){
		$('#nav_mobile_dark').css({'display':'block'});
		$('#nav_mobile_menu').css({'left':'0px'});

		$('#nav_mobile_dark').click(function(){
			$('#nav_mobile_dark').css({'display':'none'});
			$('#nav_mobile_menu').css({'left':'-300px'});
		});
	});
});