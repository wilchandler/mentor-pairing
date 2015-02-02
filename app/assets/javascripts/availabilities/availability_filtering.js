$(document).ready(function(){

	$("#city-filter").on("change", function(event){
		var city = $(this).val();

    $("#availabilities div.panel:not(#filter)").hide();
    $("#no-availability-city").text("");

    if(city === "All") {
      $("#availabilities div.panel:not(#filter, #no-availability)").fadeIn();
    } else {

      var city_availabilities = $("#availabilities div.panel[data-city='"+city+"']");

      if(city_availabilities.length > 0) {
        $("#availabilities div.panel[data-city='"+city+"']").fadeIn();
      } else {
        $("#no-availability-city").text(city);
        $("#availabilities div.panel[id='no-availability']").fadeIn();
      }

    }
	});

});