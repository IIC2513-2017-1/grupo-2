// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function () {
  $("input.search").bind("keyup", function() {

    // $(".search input").addClass("loading"); // show the spinner
    var form = $("form.search"); // grab the form wrapping the search bar.

    var url = "/products/search"; // live_search action.
    var formData = form.serialize(); // grab the data in the form
    $.get(url, formData, function(html) { // perform an AJAX get

      // $(".search input").removeClass("loading"); // hide the spinner

      $("#main-index").html(html); // replace the "results" div with the results

    });

  });
});
