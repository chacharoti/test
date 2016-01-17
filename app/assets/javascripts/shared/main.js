//= require shared/menu

var SharedMainJs = {};

(function() {
  var init = SharedMainJs.init = function(options) {
    SharedMenuJs.options = options;
    SharedMenuJs.init_mobile_menu();
  }
} ());
