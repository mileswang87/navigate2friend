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

ListController = ($scope, Friends) ->
  Friends.demo()
  $scope.friends_list = Friends.list
  Friends.list.push({name:"Miles", location:"Daly City"})

app = angular.module('pickmeup', [], ($compileProvider)->
  $compileProvider.urlSanitizationWhitelist(/^\s*(https?|ftp|mailto|file|maps):/);
)
app.filter('escape', ()->
  window.escape;
);
app.service 'Friends', FriendsClass
app.controller 'ListController', ListController