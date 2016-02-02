var SharedFullPageJS = {};

(function() {
  var init_full_page = SharedFullPageJS.init_full_page = function(page_id) {
    $('#'+ page_id).fullpage({
      'verticalCentered': true
    });
  }
} ());
