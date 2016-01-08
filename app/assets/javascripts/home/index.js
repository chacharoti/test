var HomeIndexJs = {};

(function() {
	var set_up_full_page_scroll = HomeIndexJs.set_up_full_page_scroll = function(content) {
		$('#landing_page').fullpage({
			'verticalCentered': false,
			'css3': true,
			'scrollingSpeed': 700,
			'navigation': true,
			'navigationPosition': 'right'
		});
	}
} ());