$(document).on("ajax:success", function (e, data) {


  if (data.remove) {
    $("tr[data-comment-id='" + data.comment_id + "']").remove();
  }
  else {

    $("table#comments").append(data.table_row);  // add row to table
    $("textarea#comment_content").val('');  // clear text area
    $("input#comment_attach").val('');  // clear attachment
  }

}).on('ajax:error', function (e, data) {

  console.log(data);

});
