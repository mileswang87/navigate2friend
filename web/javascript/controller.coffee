#angularJS part


FriendsClass = () ->
  @list = []
  @demo = () ->
    @list = ["Adam", "Bob", "Catherine", "Daniel"]

ListController = ($scope, Friends) ->
  Friends.demo()
  $scope.friends_list = Friends.list
  Friends.list.push("Miles")

app = angular.module('pickmeup', [])
app.service 'Friends', FriendsClass
app.controller 'ListController', ListController