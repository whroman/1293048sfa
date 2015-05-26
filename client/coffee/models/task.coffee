angular
.module('Model:Task', [
 # Dependencies
    'Collection:Form'

])
.factory 'ModelTask', (
 # Dependency Injections
    CollectionForm
) ->
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

            @form = new CollectionForm
            @form
                .set 'desc', @DESC
                .set 'cd', @display.CD

            generateRandomIncreasingInts = (num, start, mult) ->
                ints = []
                for i in [1..num] by 1
                    start += Math.floor(Math.random() * mult)
                    ints.push start

                ints

            @chart = {}
            @chart.labels = ["January", "February", "March", "April", "May", "June", "July"]
            @chart.series = ['Outstanding Category Tasks', 'Completed Category Tasks']
            @chart.data = [
                generateRandomIncreasingInts(@chart.labels.length, 100, -20),
                generateRandomIncreasingInts(@chart.labels.length, 10, 30)
            ]
