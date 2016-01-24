var SharedMenuJs = {};

(function() {
  var init_mobile_menu = SharedMenuJs.init_mobile_menu = function(content) {
    $('#toggle').click(function() {
      $(this).toggleClass('active');
      $('#overlay').toggleClass('open');
    });

    $('.full-screen-menu-item').click(function() {
      if( $('#overlay').hasClass('open') ){
      	$('#toggle').click();
      }
    });
  }
} ());