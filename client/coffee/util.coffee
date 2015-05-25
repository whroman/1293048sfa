angular
.module('Util', [
# Dependencies
])
.factory 'Util', (
# Dependency Injections
    $rootScope
    $window
) ->
    Util = {}
    Util.mediaQuery = {}
        # Cache jQuery selection, whose `z-index` value describes current media query state
    Util.mediaQuery.$el = angular.element document.getElementById('media-query')
        # Query current media query state
    Util.mediaQuery.get = ->
        this.$el.css 'z-index'

    Util.typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

    Util