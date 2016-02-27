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

    $( "#user_first_name" ).rules( "add", {
      required: true,
      minlength: 2,
    });

    $( "#user_last_name" ).rules( "add", {
      required: true,
      minlength: 2,
    });
    
    $( "#user_nickname" ).rules( "add", {
      required: true,
      minlength: 2,
    });
    
    $( "#user_birthday" ).rules( "add", {
      required: true,
    });
    
    $( "#user_gender" ).rules( "add", {
      required: true
    });
  }

  var bind_action_for_button = DevisedMainJs.bind_action_for_button = function() {
  	$('#move-second-step').click(function() {
      first_step_is_valid = $("#new_user").valid();
      if(first_step_is_valid){
      	$('.first-step').hide();
      	$('.second-step').show();
      }
  	});

  	$('#return-first-step').click(function() {
  		new WOW().init();
    	$('.first-step').show();
    	$('.second-step').hide();
  	});

  	$('#move-third-step').click(function() {
      second_step_is_valid = $("#new_user").valid();
      if(second_step_is_valid){
        $("#new_user").valid();
      	$('.first-step').hide();
      	$('.second-step').hide();
      	$('.third-step').show();
      }
  	});

  	$('#return-second-step').click(function() {
  		new WOW().init();
    	$('.first-step').hide();
    	$('.second-step').show();
    	$('.third-step').hide();
  	});

    $("#completed-sign-up").on('click', function () {
      $("#loading-state").show();
      $('#new_user').submit();
    });

    $("form#new_user").bind("ajax:success", function(e, data, status, xhr) {
      if (data.success) {
        $('#resource_id').val( data.resource_id );
        $("#s3-direct-upload").click();
      } else {
        return alert('failure!');
      }
    });    
  }

  var s3_direct_upload = DevisedMainJs.s3_direct_upload = function() {
    var form = $('#file_upload');
    $('#file_upload').fileupload({
      url: $('#file_upload').attr('action'),
      type: 'POST',
      autoUpload: true,
      dataType: 'xml',
      add: function (event, data) {
        $("#s3-direct-upload").on('click', function () {
          $.ajax({
            url: "/documents",
            type: 'POST',
            dataType: 'json',
            data: {doc: {title: data.files[0].name}, user_id: $('#resource_id').val()},
            async: false,
            success: function(data) {            
              form.find('input[name=key]').val(data.key);
              form.find('input[name=policy]').val(data.policy);
              form.find('input[name=signature]').val(data.signature);
            }
          })        
          data.submit();
        });
      },
      send: function(e, data) {
        $("#loading-state").show();
      },
      progress: function(e, data){
      },
      fail: function(e, data) {
      },
      success: function(data) {        
        var url = $(data).find('Location').text();
        var resource_id = $('#resource_id').val();
        var url_params = {
          normal_size_url: url
        };
        $.ajax({
          type: "PUT",
          url: '/users/' + resource_id + '/add_media',
          data: url_params,
          beforeSend: function( xhr ) {
          },
          complete: function( xhr,status ) {
            $('.first-step').hide();
            $('.second-step').hide();
            $('.third-step').hide();
            $('.fourth-step').show();
            $('#sign-up-container').addClass('green-background');
            $('h1.row').hide();
          }
        })
        
      },
      done: function (event, data) {
        $("#loading-state").hide();
      },
    })
  }

  var load_profile_picture = DevisedMainJs.load_profile_picture = function() {
    $("#user_profile_photo").change(function(){
      $('.choose-image-wrap').hide();
      $('#display-img-url').fadeIn('1000');
      readURL(this);
    });
  }

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();            
      reader.onload = function (e) {
          $('#display-img-url').attr('src', e.target.result);
      }      
      reader.readAsDataURL(input.files[0]);
    }
  }  
} ());
