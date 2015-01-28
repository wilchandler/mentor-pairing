$(document).ready(function(){

	$("#city-filter").on("change", function(event){
		var city = $(this).val();

    $("#availabilities div.panel:not(#filter)").fadeOut();

    if(city === "All") {
      $("#availabilities div.panel:not(#filter)").fadeIn();
    } else {
      $("#availabilities div.panel[data-city='"+city+"']").fadeIn();
    }
	});

});