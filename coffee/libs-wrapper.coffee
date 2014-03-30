# TODO: if selector has no dot, then its key for @SELECTORS hash or tagName
getElements = (selector, parent) ->
    if parent
        elements = parent.querySelectorAll selector
    else
        elements = document.querySelectorAll selector
    elements


# TODO: if selector has no dot, then its key for @SELECTORS hash or tagName
getElement = (selector, parent) ->
    if parent
        element = parent.querySelector selector
    else
        element = document.querySelector selector
    element


# TODO: remove 'if context'
listen = (target, type, handler, context) ->
    if target instanceof NodeList
        onElement = (element) ->
            listen element, type, handler, context
        _.each target, onElement, context
    else
        if context
            Gator(target).on type, _.bind(handler, context)
        else
            Gator(target).on type, handler


# TODO: remove 'if context'
unlisten = (target, type, handler, context) ->
    if target instanceof NodeList
        onElement = (element) ->
            listen element, type, handler, context
        _.each target, onElement, context
    else
        if context
            Gator(target).off type, _.bind(handler, context)
        else
            Gator(target).off type, handler


# TODO: remove 'if context'
ajaxGet = (url, data, onSuccess, context, options) ->
    if !options
        options =
            cache: true
    if context
        successCallback = _.bind(onSuccess, context)
    else
        successCallback = onSuccess

    qwest.get(url, data, options).success(successCallback)


# TODO: remove 'if context'
ajaxPost = (url, data, onSuccess, context, options) ->
    if !options
        options =
            cache: true
    if context
        successCallback = _.bind(onSuccess, context)
    else
        successCallback = onSuccess

    qwest.post(url, data, options).success(successCallback)
