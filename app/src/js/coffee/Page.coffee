window.Page = Backbone.Model.extend
    defaults:
        position: 1
        html: """<div class="loader"></div>"""

    initialize: () ->
        @loader_html = @get('html')

        if config.login_required
            unless @no_login_required?
                unless config.token?
                    console.log "login is required to access this page", JSON.stringify @get('link')
                    _.delay =>
                        app.navigate config.uri.login
                    , 600
                    return

    isActive: () ->
        @get("position") is 0


window.PageCollection = Backbone.Collection.extend
    model: Page

    hasPage: (link) ->
        uriList = @map (element, index) -> $.param element.get "link"
        index = _.indexOf uriList, $.param link

        if index is -1 then false else index

window.PageView = Backbone.View.extend
    className: "page"

    initialize: () ->
        _.bindAll this

        @model.on "change:position", @onChangePosition
        @model.on "change:html", @render

    onChangePosition: () ->
        _.delay () =>     # wait for 1 frame
            @updatePosition()
        , 30

    updatePosition: () ->
        screenWidth = window.screenWidth
        position = @model.get("position")

        unless config.fixed_header
            @$el.toggle (position is 0)
        else
            if position < 0
                @$el.css "-webkit-transform", "translate3d(-#{screenWidth}px,0px,0px)"
                @$el.css "-moz-transform", "translate3d(-#{screenWidth}px,0px,0px)"
                @$el.css "-o-transform", "translate3d(-#{screenWidth}px,0px,0px)"
                @$el.css "transform", "translate3d(-#{screenWidth}px,0px,0px)"
            else if position > 0
                @$el.css "-webkit-transform", "translate3d(#{screenWidth}px,0px,0px)"
                @$el.css "-moz-transform", "translate3d(#{screenWidth}px,0px,0px)"
                @$el.css "-o-transform", "translate3d(#{screenWidth}px,0px,0px)"
                @$el.css "transform", "translate3d(#{screenWidth}px,0px,0px)"
            else if position is 0
                @$el.css "-webkit-transform", "translate3d(0px,0px,0px)"
                @$el.css "-moz-transform", "translate3d(0px,0px,0px)"
                @$el.css "-o-transform", "translate3d(0px,0px,0px)"
                @$el.css "transform", "translate3d(0px,0px,0px)"

        @$el.toggleClass "active", @model.isActive()

    render: () ->
        if @model.get('link')? then @$el.addClass @model.get('link').type

        contents = $("<div class='contents'></div>")
        contents.append @model.get("html")

        @$el.html contents

        @pageSpecificRender() unless @model.get('html') is @model.loader_html

        Fixes.iPhoneOverflowScroll @$el, contents
        @updatePosition()
        this

    # override this function in other pages
    pageSpecificRender: () ->
        return
