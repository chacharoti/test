var HomeIndexJs = {};

(function() {
	var set_up_full_page_scroll = HomeIndexJs.set_up_full_page_scroll = function(content) {
		$('#landing_page').fullpage({
			'verticalCentered': false,
			'css3': true,
			'scrollingSpeed': 700,
			'navigation': true,
			'navigationPosition': 'right',
			'scrollBar': true,
        onLeave: function(index, nextIndex, direction){
          if( nextIndex == 1 ){
            $('#main-nav').removeClass('fix-menu');
          }else{
            $('#main-nav').addClass('fix-menu');
          }
        }
		});
	}
} ());