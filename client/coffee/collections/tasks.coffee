angular
.module('Collection:Tasks', [
 # Dependencies
    'Util'
    'Model:Task'
])
.factory 'CollectionTasks', (
 # Dependency Injections
    Util
    ModelTask
) ->

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
                @all.push( new ModelTask task )

            return @

        contains: (uid) ->
            @all[uid] isnt undefined

    CollectionTasks