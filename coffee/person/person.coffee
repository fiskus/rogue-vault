class Person
    constructor: (name, health, sex) ->
        eventController = new PersonEvents()
        events = eventController.getSignals()
        new PersonModel(events, name, health, sex)
        new PersonIndicator(events, name, health, sex)
