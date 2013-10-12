#angularJS part


FriendsClass = () ->
  @list = []
  @demo = () ->
    @list = ["1", "2", "3"]

ListController = ($scope, Friends) ->
  Friends.demo()
  $scope.friends_list = Friends.list
  $scope.name_1 = 123

app = angular.module('pickmeup', [])
app.service 'Friends', FriendsClass
app.controller 'ListController', ListController