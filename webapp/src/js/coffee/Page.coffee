window.Page = Backbone.Model.extend
    defaults:
        position: 0

    initialize: () ->
        firstpage = (app.pageManager.pageCollection.length is 0)
        unless firstpage
            @set position: 1

    isActive: () ->
        @get("position") is 0


window.PageCollection = Backbone.Collection.extend
    model: Page

    hasPage: (uri) ->
        uriList = @pluck("uri")
        index = _.indexOf uriList, uri

        if index is -1 then false else index

window.PageView = Backbone.View.extend
    className: "page"
    template: Templates.stub
    context: {}

    initialize: () ->
        _.bindAll this
        @model.on "change:position", @onChangePosition

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
        @context = @contextForTemplate()
        @context.uri = @model.get('uri')

        contents = $("<div class='contents'></div>")
        contents.append @template(@context)
            
        @$el.html contents

        @pageSpecificRender()

        Fixes.iPhoneOverflowScroll @$el, contents
        @updatePosition()
        this

    # override this function in other pages
    pageSpecificRender: () ->
        return

    # override this function in other pages
    contextForTemplate: () ->
        return {}
