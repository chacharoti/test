var DevisedMainJs = {};

(function() {
	var validate_sign_in = DevisedMainJs.validate_sign_in = function() {
  	$("#new_user").validate();
  }

  var validate_sign_up_first_step = DevisedMainJs.validate_sign_up_first_step = function() {
  	$("#new_user").validate();

  	$( "#user_email" ).rules( "add", {
	    remote: {
        url: "/users/check_valid_email",
        type: "get"
      },
      messages: {
		    remote: "Email has been used. Please use another email."
		  }
	  });

		$( "#user_email_confirmation" ).rules( "add", {
	    equalTo: "#user_email",
	    messages: {
		    equalTo: "Your email is not match. Please try again."
		  }
	  });

	  $( "#user_password" ).rules( "add", {
	    minlength: 6
	  });  	
  }

  var bind_action_for_button = DevisedMainJs.bind_action_for_button = function() {
  	$('#move-second-step').click(function() {
  		new WOW().init();
      first_step_is_valid = $("#new_user").valid();
      if(first_step_is_valid){
      	$('.form-first-step').hide();
      	$('.form-second-step').show();
      }
  	});

  	$('#return-first-step').click(function() {
  		new WOW().init();
    	$('.form-first-step').show();
    	$('.form-second-step').hide();
  	});
  }
} ());
