window.Router = Backbone.Router.extend
    routes:
        "*uri" : "onRouteChanged"

    onRouteChanged: (uri) ->
        unless uri is ''
            Cache.storeInLocalStorage "last_position", uri