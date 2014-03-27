// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
var postForm = function(form) {  
  var valuesToSubmit = $(form).serialize();
  $.ajax({
      type: 'POST',
      url: $(form).attr('action'), //sumbits it to the given url of the form
      data: valuesToSubmit
  });
}