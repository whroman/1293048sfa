angular
.module('Collection:Tasks', [
 # Dependencies
    'Util'
])
.factory 'CollectionTasks', (
 # Dependency Injections
    $rootScope
    Util
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

    class Form
        constructor: () ->
            @all = {};

        set: (name, initVal) ->
            @all[name] = new Input name, initVal

            @

    class Task
        constructor: (task) ->
            # Data
            @NAME = task.NAME
            @CODE = task.CODE
            @DESC = task.DESC
            @ID = task.ID
            @CATEGORY = task.CATEGORY
            @CD = parseInt task.CD

            # UI
            @isSelected = false

            @display = {}
            @display.CD = moment(@CD, 'x').format('YYYY-M-D')

            @onClick = ($event) ->
                if $event.keyCode
                    return
                @isSelected = !@isSelected

            @form = new Form
            @form
                .set 'desc', @DESC
                .set 'cd', @display.CD

    class CollectionTasks
        constructor: () ->
            @all = []
            @order = {};
            @order.keys = [
                'Name': 'NAME'
                'Code': 'CODE'
                'Description': 'DESC'
                'Completion Date': 'CD'
            ]
            @order.by = 'CD'
            @order.reverse = false
            @order.set = (fieldName) ->
                if fieldName is @by
                    @reverse = !@reverse
                else
                    @reverse = false

                @by = fieldName

        get: (uid) ->
            @all[uid]

        set: (task) ->
            if Util.typeIsArray task
                tasksArray = task
                for task in tasksArray

                    @set task

            else
                @all.push( new Task task )

            return @

        contains: (uid) ->
            @all[uid] isnt undefined



    CollectionTasks