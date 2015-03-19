$(document).ready(function(){
  $("#appointment_request").on("submit", function(event){
    var fields = [$("#first_name"), $("#last_name"), $("#email")];
    return toggleErrors(fields);
  });
});

