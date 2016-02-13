var DevisedMainJs = {};

(function() {
	var validate_sign_in = DevisedMainJs.validate_sign_in = function() {
  	$("#new_user").validate();
  }

  var validate_sign_up_first_step = DevisedMainJs.validate_sign_up_first_step = function() {
  	$('#move-second-step').click(function() {
      $("#new_user").valid();
  	});
  }
} ());
