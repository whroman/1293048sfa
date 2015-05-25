# Apply this directive to an <input> element.
#    - The element will be "focused" when the given value is true (value === true)
#    - When the element is blurred, the given value will be set to false
#
# Example:
# When #address-wrapper is clicked, the browser's focus will shift to input#address

# <div
#     id="address-wrapper"
#     ng-init="focusInputAddress = false"
#     ng-click="focusInputAddress = true"
# >
#   <label for="address">Address:</label>
#   <input
#       id="address"
#       type="text"
#       ng-model="address"
#       focus-when="focusInputAddress"
#   />
#   <div id="confirmAddressIcon"></div>
# </div>
# //
# - Walter Roman

angular
.module 'focusWhen', []
.directive 'focusWhen', ($timeout, $parse) ->
    {
        link: (scope, element, attrs) ->
            model = $parse attrs.focusWhen
            scope.$watch model, (value) ->
                if value is true
                    # $timeout in place to give elements time to render
                    $timeout () ->
                        element[0].focus()

            element.bind 'blur', ->
                 scope.$apply model.assign scope, false
    }