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
    Util
) ->
    $scope.util = Util
    $scope.tasks = new CollectionTasks

    $scope.tasks.set $window.tasks

    $scope.foo = {bar: true}

    $scope.$on 'task:detail', (event, productId) ->
        # $scope.modal.open productId

    $window.logScope = ->
        $window.$scope = $scope