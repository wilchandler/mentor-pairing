$(document).ready(function(){

	$("#city-filter").on("change", function(event){
		var city = $(this).val();
		$("#availabilities div.panel[data-city='"+city+"']").fadeIn();
		$("#availabilities div.panel:not(div.panel[data-city='"+city+"'])").fadeOut();
	});

});