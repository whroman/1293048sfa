angular
.module('Collection:Form', [
 # Dependencies
    'Model:Input'
])
.factory 'CollectionForm', (
 # Dependency Injections
    ModelInput
) ->

    class Form
        constructor: () ->
            @all = {};

        set: (name, initVal) ->
            @all[name] = new ModelInput name, initVal

            @
