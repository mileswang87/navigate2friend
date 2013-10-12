#angularJS part


FriendsClass = () ->
  @list = []
  @demo = () ->
    @list = [
      name:"Adam",
      location:"37.47,-122.25"
    ,
      name:"bob",
      location:"San Francisco"
    ]

LocationService = () ->
  @current_location = "Current+Location"


ListController = ($scope, $http, Friends, Location) ->
#  Friends.demo()
  $scope.friends = Friends
  $scope.location = Location
  ua = navigator.userAgent.toLowerCase()
  $scope.ios = ua.match /ipad|iphone/
  #  console.log ios
  navigator.geolocation?.getCurrentPosition((position)->
    Location.current_location = position.coords.latitude.toString() + "," + position.coords.longitude.toString()
    #console.log(position, $scope.location.current_location)
    $scope.$digest()
    # alert $scope.clt
  )
  pull = ()->
    p =
      method: 'GET',
      url: "../list",
      cache: false
    $http(p)
    .success((data)->
#        console.log(data)
        Friends.list = data
      )
    .error(()->
        console.log arguments
      )
  pull()


app = angular.module('pickmeup', [], ($compileProvider)->
  $compileProvider.urlSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|maps):/);
)

ajaxGet = ()->
app.filter('escape', ()->
  window.escape;
);
app.service 'Friends', FriendsClass
app.service 'Location', LocationService
app.controller 'ListController', ListController