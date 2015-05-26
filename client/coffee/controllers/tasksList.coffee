angular
.module('Controller:TasksList', [
    'Collection:Tasks'
    'Util'
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

    $window.logScope = ->
        $window.$scope = $scope