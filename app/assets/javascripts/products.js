// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load', function () {

  $("input.search").bind("keyup", function() {

    $("div.sidebar-item").each(function() {
      $(this).removeClass("active");
    });

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

  $("div.sidebar-item").on('click', function() {
    var btn = $(this);

    $("div.sidebar-item").each(function() {
      $(this).removeClass("active");
    });

    $("input.search").val("");

    btn.addClass("active");
  });

  var slideCount1 = $('.slider1 ul li').length;
	var slideWidth1 = $('.slider1 ul li').width();
	var slideHeight1 = $('.slider1 ul li').height();
	var sliderUlWidth1 = slideCount1 * slideWidth1;
	$('.slider1').css({ width: slideWidth1, height: slideHeight1 });
	$('.slider1 ul').css({ width: sliderUlWidth1, marginLeft: - slideWidth1 });
  $('.slider1 ul li:last-child').prependTo('.slider1 ul');

  function moveLeft1() {
    $('.slider1 ul').animate({
      left: + slideWidth1
    }, 200, function () {
      $('.slider1 ul li:last-child').prependTo('.slider1 ul');
      $('.slider1 ul').css('left', '');
    });
  };
  function moveRight1() {
    $('.slider1 ul').animate({
      left: - slideWidth1
    }, 200, function () {
      $('.slider1 ul li:first-child').appendTo('.slider1 ul');
      $('.slider1 ul').css('left', '');
    });
  };
  $('.slider1 a.control-prev').click(function (e) {
    e.preventDefault();
    moveLeft1();
  });
  $('.slider1 a.control-next').click(function (e) {
    e.preventDefault();
    moveRight1();
  });

  var slideCount2 = $('.slider2 ul li').length;
	var slideWidth2 = $('.slider2 ul li').width();
	var slideHeight2 = $('.slider2 ul li').height();
	var sliderUlWidth2 = slideCount2 * slideWidth2;
	$('.slider2').css({ width: slideWidth2, height: slideHeight2 });
	$('.slider2 ul').css({ width: sliderUlWidth2, marginLeft: - slideWidth2 });
  $('.slider2 ul li:last-child').prependTo('.slider2 ul');

  function moveLeft2() {
    $('.slider2 ul').animate({
      left: + slideWidth2
    }, 200, function () {
      $('.slider2 ul li:last-child').prependTo('.slider2 ul');
      $('.slider2 ul').css('left', '');
    });
  };
  function moveRight2() {
    $('.slider2 ul').animate({
      left: - slideWidth2
    }, 200, function () {
      $('.slider2 ul li:first-child').appendTo('.slider2 ul');
      $('.slider2 ul').css('left', '');
    });
  };
  $('.slider2 a.control-prev').click(function (e) {
    e.preventDefault();
    moveLeft2();
  });
  $('.slider2 a.control-next').click(function (e) {
    e.preventDefault();
    moveRight2();
  });
});
