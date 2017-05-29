// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function () {
  
  $("input.search").bind("keyup", function() {
    var form = $("form.search");
    var url = "/products/search";
    var formData = form.serialize();
    $.get(url, formData, function(html) {
      $("#main-index").html(html);
    });
  });

  $(document).on('ajax:success', function(e, data) {
    $("#main-index").html(data);
  }).on('ajax:error', function (e, data) {
    console.log(data);
  });
});
