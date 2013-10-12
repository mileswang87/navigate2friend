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



ListController = ($scope, $http, Friends) ->
#  Friends.demo()
  $scope.friends = Friends
#  Friends.list.push({name:"Miles", location:"Daly City"})
  pull = ()->
    p =
      method: 'GET',
      url: "../list",
      cache: false
    $http(p)
    .success((data)->
        console.log(data)
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
app.controller 'ListController', ListController