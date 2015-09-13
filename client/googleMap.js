function initMap(location) {
  location = location || 'San Francisco'
  var map = new google.maps.Map(document.getElementById('map'), {zoom: 12});
  var geocoder = new google.maps.Geocoder;
  var data = {
    'address': location,
    componentRestrictions: {
      administrativeArea: 'California'
    }
  };
  geocoder.geocode(data, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      window.alert('Geocode was not successful for the following reason: ' +
          status);
    }
  });

  google.maps.event.addListenerOnce(map, 'idle', function(){
    google.maps.event.trigger(map, 'resize');
    map.setCenter(location);
  });
}