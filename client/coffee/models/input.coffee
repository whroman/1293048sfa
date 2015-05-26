angular
.module('Model:Input', [
 # Dependencies
])
.factory 'ModelInput', (
 # Dependency Injections
) ->
    class Input
        constructor: (name, initialValue) ->
            @val = initialValue
            @input = initialValue
            @hasChanged = false
            @focused = false

        reset: ($event) ->
            console.log 'reset'
            @input = @val
            @onChange()
            if $event
                $event.stopPropagation()

        save: ($event) ->
            console.log 'save'
            @val = @input
            @onChange()
            if $event
                $event.stopPropagation()

        onFocus: ->
            if !@hasChanged
                @reset()

        onClick: ($event) ->
            @focused = true
            if $event
                $event.stopPropagation()

        onChange: ->
            @hasChanged = @val isnt @input

        onKeypress: ($event) ->
            if $event.keyCode is 27 # 27 = escape key
                @reset($event)

            if $event.keyCode is 13 # 13 = enter key
                @save($event)