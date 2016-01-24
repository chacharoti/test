var HomeIndexJs = {};

(function() {
	var init_full_page_scroll = HomeIndexJs.init_full_page_scroll = function(content) {
		$('#landing_page').fullpage({
			'verticalCentered': false,
			'css3': true,
      anchors:['welcome-milispace', 'see-what-hot-nearby', 'find-people-around', 'chatting-and-making-friends', 'follow-and-share', 'history-activities', 'follow-and-download'],
			'scrollingSpeed': 700,
			'navigation': true,
			'navigationPosition': 'right',
			'scrollBar': true,
      onLeave: function(index, nextIndex, direction){
        if( nextIndex == 1 ){
          $('#main-nav').removeClass('fix-menu');
          $('#mobile-menu').removeClass('fix-mobile-menu');
        }else{
          $('#main-nav').addClass('fix-menu');
          $('#mobile-menu').addClass('fix-mobile-menu');
        }
      }
		});
	}

  var init_mobile_menu = HomeIndexJs.init_mobile_menu = function(content) {
    $('#toggle').click(function() {
      $(this).toggleClass('active');
      $('#overlay').toggleClass('open');
    });
  }
} ());