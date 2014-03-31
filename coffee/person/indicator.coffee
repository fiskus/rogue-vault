class PersonIndicator
    SELECTORS:
        WRAPPER: '.personslist'
        HEALTH_BAR: '.person-health'


    CLASSNAMES:
        CONTAINER: 'person-wrapper'


    TEMPLATE: JST['handlebars/person.hbs']


    constructor: (events, name, health, sex) ->
        @_events = events
        @_name = name
        @_health = health
        @_sex = sex
        @render()


    render: () ->
        docfrag = document.createDocumentFragment()
        @_wrapper = getElement @SELECTORS.WRAPPER
        @_container = document.createElement 'div'
        @_container.classList.add @CLASSNAMES.CONTAINER
        @_container.innerHTML = @getHtml()
        docfrag.appendChild @_container
        @_wrapper.appendChild docfrag
        @onRender()


    getHtml: () ->
        data =
            health: @_health
            name: @_name
            sex: @_sex
        @TEMPLATE data


    onRender: () ->
        listen @_container, 'click', @onClick, @
        healthListener = @_events.health.add @onHealth, @
        healthListener.params = [@_name]
        @_healthBar = getElement @SELECTORS.HEALTH_BAR, @_container


    onClick: (event) ->
        publish 'click.personindicator', [@_name, @_container]


    onHealth: (name, health) ->
        if name != @_name
            return
        @_healthBar.style.width = health + 'px'
