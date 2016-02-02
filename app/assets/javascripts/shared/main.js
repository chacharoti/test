//= require shared/menu
//= require shared/full_page

var SharedMainJs = {};

(function() {
  var init = SharedMainJs.init = function(options) {
    SharedMenuJs.options = options;
    SharedMenuJs.init_mobile_menu();
  }

  var set_full_page = SharedMainJs.set_full_page = function(page_id) {
    SharedFullPageJS.init_full_page(page_id);
  }
} ());
