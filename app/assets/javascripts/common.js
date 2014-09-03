
function fadein_flash(msg){
  $('.flash').fadeIn('slow');
	setTimeout(function(){
	    $('.flash').fadeOut();
	  }, 4000);
}
