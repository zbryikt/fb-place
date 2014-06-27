main = ($scope, $http) ->
  console.log \ok
  map-option = do
    center: new google.maps.LatLng 25.040539,121.551485
    zoom: 16
    minZoom: 8
    maxZoom: 18
    mapTypeId: google.maps.MapTypeId.ROADMAP
  $scope.iconSize = 24
  $scope.icon = [{
      url: \unit-price-small.png
      size: new google.maps.Size($scope.iconSize,$scope.iconSize)
      origin: new google.maps.Point(
        parseInt( i / 10 ) * $scope.iconSize <?($scope.iconSize * 10 - $scope.iconSize),
        ( i % 10 ) * $scope.iconSize <?($scope.iconSize * 10 - $scope.iconSize))
  } for i from 0 to 100]
  map = new google.maps.Map document.getElementById(\map-node), map-option
  google.maps.event.addListenerOnce map, \idle, -> google.maps.event.trigger map, \resize
  $http do
    url: \/count.json
    method: \GET
  .success (c) ->
    console.log c
    $http do
      url: \/starbucks.json
      method: \GET
    .success (d) ->
      console.log \ok
      d.data.map (v) ->
        count = c[v.id]
        console.log v.id, c[v.id], v.location.latitude, v.location.longitude, (parseInt(count/100)>?1<?100)
        m = new google.maps.Marker do
          zIndex: 9900000
          position: new google.maps.LatLng v.location.latitude, v.location.longitude
          map: map
          icon: $scope.icon[parseInt(count/100)>?1<?100]
