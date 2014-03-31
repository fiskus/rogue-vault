class PersonModel
    constructor: (events, name, health, sex) ->
        @_events = events
        @_name = name
        @_health = health
        @_sex = sex
        subscribe 'click.personindicator', _.bind(@onClick, @)


    onClick: (name, container) ->
        if name != @_name
            return
        @changeHealth -10


    changeHealth: (diff) ->
        @_health = @_health + diff
        @_events.health.dispatch @_health
