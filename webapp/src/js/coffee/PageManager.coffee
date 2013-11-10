window.PageManager = Backbone.Model.extend
    defaults:
        active: null
        
    initialize: () ->
        _.bindAll this

        @pageCollection = new PageCollection()
        @pageCollection.on "remove", @onRemove

        @on "change:active", @onChangeActive
        app.router.on 'route:onRouteChanged', @addOrSwitchToPage

    onRemove: (model) ->
        if model.get('position') is 0
            # currently displayed paged is thrown faaaaar away to the right
            model.set position: model.get("position") + 10000

    updatePositions: () ->
        @pageCollection.each (element, index) =>
            element.set position: index - @get("active")
    
    onChangeActive: (model, value, options) ->
        @updatePositions()
        @loadingIndicator()

    loadingIndicator: () ->
        if @getActivePage()? and @getActivePage().get("html") is ""
            @set isLoading: true
            @getActivePage().once "change:html", @loadingFinished
        else
            @set isLoading: false

    loadingFinished: () ->
        clearTimeout @get("loadTimeout")
        @set "loadTimeout" : setTimeout () =>
                @set isLoading: false
            , 500

    addOrSwitchToPage: (uri) ->
        reuse_pages = false
        found = reuse_pages and @pageCollection.hasPage(uri)

        if found is false
            # new page
            pageClassName = @classForType uri
            newPage = new pageClassName uri: uri

            @pageCollection.add newPage

            if @get("active")? then newActive = @get("active") + 1
            else newActive = 0
        else
            if @pageCollection.length > 1
                # destroy old ones on the right
                pagesToRemove = @pageCollection.rest found+1
                @pageCollection.remove pagesToRemove
            newActive = found

        @trackPage uri

        # defer is needed here. active must be set on the next animation frame.
        _.defer () => @set active: newActive

    clearHistory: () ->
        if @pageCollection.length > 1
            pagesToRemove = @pageCollection.initial() # everything except last element
            @pageCollection.remove pagesToRemove
            _.defer () => @set active: 0

    getActivePage: () ->
        return @pageCollection.at @get("active")

    # Overrides for Page and PageView
    classForType: (uri, asView=false) ->
        className = if uri is "" then "" else uri.charAt(0).toUpperCase() + uri.slice(1)

        className += "Page"
        className += "View" if asView

        unless window[className]?
            className = if asView then "PageView" else "Page"

        return window[className]

    trackPage: (uri) ->
        if _gaq? then _gaq.push(['_trackPageview', "/"+uri]);


window.PageManagerView = Backbone.View.extend
    initialize: () ->
        _.bindAll this

        @notifications = []

        @loadingIndicator = $(".loading")

        @model.pageCollection.on "reset", @render
        @model.pageCollection.on "add", @addPage
        @model.pageCollection.on "remove", @removePage
        @model.on "change:isLoading", @loadingChanged
        @model.on "change:active", @clearNotifications

    addPage: (page) ->
        pageViewClass = @model.classForType page.get('uri'), asView=true
        pageElement = (new pageViewClass model: page).render().$el
        unless page.get("pageElement") then page.set pageElement: pageElement
        @$el.append pageElement

    removePage: (model) ->
        _.delay () ->
            pageElement = model.get("pageElement")
            pageElement.remove()
        , 400

    loadingChanged: () ->
        @loadingIndicator.toggleClass "animate", @model.get("isLoading")

    render: () ->
        @$el.empty()
        @model.pageCollection.each (element, index) => @addPage element
        return this
