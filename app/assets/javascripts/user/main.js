var UserMainJs = {};

(function() {
  var set_user_location = UserMainJs.set_user_location = function(page_id) {
    setUserLocation();
  }

  function showLocation(position) {    
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    var params = {
      id: $('#user_id').val(),
      location_params: {
        latitude: latitude,
        longitude: longitude
      }
    };
    $.ajax({
      type: "POST",
      url: '/users/add_user_location',
      data: params,
      beforeSend: function( xhr ) {
      },
      complete: function( xhr,status ) {
      }
    })
  }

  function errorHandler(err) {
    if(err.code == 1) {
       alert("Error: Access is denied!");
    }else if( err.code == 2) {
       alert("Error: Position is unavailable!");
    }
  }

  function setUserLocation(){
    if(navigator.geolocation){
      var options = {timeout:60000};
      navigator.geolocation.getCurrentPosition(showLocation, errorHandler, options);
    }else{
       alert("Sorry, browser does not support geolocation!");
    }
  }
} ());