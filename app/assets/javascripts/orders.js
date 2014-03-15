
// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var makeCall = function() {  
  var valuesToSubmit = $('#new_order').serialize();
  $.ajax({
      type: 'POST',
      url: $('#new_order').attr('action'), //sumbits it to the given url of the form
      data: valuesToSubmit
  });
}
var postForm = function(form) {  
  var valuesToSubmit = $(form).serialize();
  $.ajax({
      type: 'POST',
      url: $(form).attr('action'), //sumbits it to the given url of the form
      data: valuesToSubmit
  });
}
// $(function(){
//   $("#submit_form").click(function( event ) {
//     event.preventDefault();
//     makeCall();
//   });
//   $("#submit_confirmation").click(function( event ) {
//     event.preventDefault();
//     postForm('#confirmation_form');
//   });
// });