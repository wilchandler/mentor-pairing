function toggleErrors(fields) {
  var noErrors = true;

  for(var i = 0; i < fields.length; i++) {

    if(fields[i].val()) {
      fields[i].removeClass("field_error");
    } else {
      noErrors = false;
      fields[i].addClass("field_error");
    }

  }

  return noErrors;
}