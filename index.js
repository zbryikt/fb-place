// Generated by LiveScript 1.2.0
var main;
main = function($scope, $http){
  var mapOption, res$, i$, i, ref$, ref1$, map;
  console.log('ok');
  mapOption = {
    center: new google.maps.LatLng(25.040539, 121.551485),
    zoom: 16,
    minZoom: 8,
    maxZoom: 18,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  $scope.iconSize = 24;
  res$ = [];
  for (i$ = 0; i$ <= 100; ++i$) {
    i = i$;
    res$.push({
      url: 'unit-price-small.png',
      size: new google.maps.Size($scope.iconSize, $scope.iconSize),
      origin: new google.maps.Point((ref$ = parseInt(i / 10) * $scope.iconSize) < (ref1$ = $scope.iconSize * 10 - $scope.iconSize) ? ref$ : ref1$, (ref$ = (i % 10) * $scope.iconSize) < (ref1$ = $scope.iconSize * 10 - $scope.iconSize) ? ref$ : ref1$)
    });
  }
  $scope.icon = res$;
  map = new google.maps.Map(document.getElementById('map-node'), mapOption);
  google.maps.event.addListenerOnce(map, 'idle', function(){
    return google.maps.event.trigger(map, 'resize');
  });
  return $http({
    url: '/count.json',
    method: 'GET'
  }).success(function(c){
    console.log(c);
    return $http({
      url: '/starbucks.json',
      method: 'GET'
    }).success(function(d){
      console.log('ok');
      return d.data.map(function(v){
        var count, ref$, ref1$, m;
        count = c[v.id];
        console.log(v.id, c[v.id], v.location.latitude, v.location.longitude, (ref$ = (ref1$ = parseInt(count / 100)) > 1 ? ref1$ : 1) < 100 ? ref$ : 100);
        return m = new google.maps.Marker({
          zIndex: 9900000,
          position: new google.maps.LatLng(v.location.latitude, v.location.longitude),
          map: map,
          icon: $scope.icon[(ref$ = (ref1$ = parseInt(count / 100)) > 1 ? ref1$ : 1) < 100 ? ref$ : 100]
        });
      });
    });
  });
};