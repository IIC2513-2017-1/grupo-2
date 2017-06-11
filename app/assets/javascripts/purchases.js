// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on("ajax:success", function (e, data) {


  if (data.confirmed) {
    $("table[data-remove='true'] tr[data-purchase-id='" + data.confirmed.id + "']").remove();
    $("table[data-remove='false'] tr[data-purchase-id='" + data.confirmed.id + "'] td[data-payment='true']").text("Confirmed!");
    $("table[data-remove='false'] tr[data-purchase-id='" + data.confirmed.id + "'] td.actions i").removeClass("fa fa-check").addClass("fa fa-times");
  }
  else if (data.unconfirmed) {
    $("table[data-remove='false'] tr[data-purchase-id='" + data.unconfirmed.id + "'] td[data-payment='true']").text("Pending...");
    $("table[data-remove='false'] tr[data-purchase-id='" + data.unconfirmed.id + "'] td.actions i").removeClass("fa fa-times").addClass("fa fa-check");
  }

}).on('ajax:error', function (e, data) {

  console.log(data);

});
