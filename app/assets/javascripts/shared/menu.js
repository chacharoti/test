var SharedMenuJs = {};

(function() {
  var init_mobile_menu = SharedMenuJs.init_mobile_menu = function(content) {
    $('#toggle').click(function() {
      $(this).toggleClass('active');
      $('#overlay').toggleClass('open');
    });
  }
} ());