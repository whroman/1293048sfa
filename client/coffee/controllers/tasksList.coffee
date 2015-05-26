angular
.module('Controller:TasksList', [
    'Collection:Tasks'
])
.controller 'Controller:TasksList', (
# Dependency Injections
    $scope
    $window
    $http
    CollectionTasks
) ->
    $scope.tasks = new CollectionTasks

    $scope.tasks.set $window.tasks
