<!Doctype html>
<html>
<head>
<style>
html,
body {
  margin: 0;
  padding: 0;
}
body {
    background-image: url("res/bg.jpg");
    background-repeat: repeat-x;
}
h2 {
    text-shadow: 1px 2px red;
    letter-spacing: 3px;
    text-align: center;
}
h2.capitalize {
    text-transform: capitalize;
}

#map {
  border-style: groove;
  height: 500px;
  margin: 10px auto;
  width: 800px;
}
}
</style>
</head>
<body>
<h2>Nearby Universities</h2>
<div id="map"></div>
<script>
   var map;

            function initMap() {
              if (navigator.geolocation) {
                try {
                  navigator.geolocation.getCurrentPosition(function(position) {
                    var myLocation = {
                       lat:30.3664335,
                   lng:78.0681515
                    };
                    setPos(myLocation);
                  });
                } catch (err) {
                  var myLocation = {
                   lat:30.3254098,
                   lng:77.947094
                  };
                  setPos(myLocation);
                }
              } else {
                var myLocation = {
                 lat:30.3254098,
                 lng:77.947094
                };
                setPos(myLocation);
              }
            }

            function setPos(myLocation) {
              map = new google.maps.Map(document.getElementById('map'), {
                center: myLocation,
                zoom: 10
              });

              var service = new google.maps.places.PlacesService(map);
              service.nearbySearch({
                location: myLocation,
                radius: 5000,
                types: ['university']
              }, processResults);

            }

            function processResults(results, status, pagination) {
              if (status !== google.maps.places.PlacesServiceStatus.OK) {
                return;
              } else {
                createMarkers(results);

              }
            }

            function createMarkers(places) {
              var bounds = new google.maps.LatLngBounds();
              var placesList = document.getElementById('places');

              for (var i = 0, place; place = places[i]; i++) {
                var image = {
                  url: place.icon,
                  size: new google.maps.Size(71, 71),
                  origin: new google.maps.Point(0, 0),
                  anchor: new google.maps.Point(17, 34),
                  scaledSize: new google.maps.Size(25, 25)
                };

                var marker = new google.maps.Marker({
                  map: map,
                  icon: image,
                  title: place.name,
                  animation: google.maps.Animation.DROP,
                  position: place.geometry.location
                });

                bounds.extend(place.geometry.location);
              }
              map.fitBounds(bounds);
            }
            </script>
 <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBIAhI7MAPLyGKHHkt-QBnyjPdITrz5NDY&signed_in=true&libraries=places&callback=initMap" async defer></script>
</body>
</html>

</body>
</html>
