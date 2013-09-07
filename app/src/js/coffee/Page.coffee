window.Page = Backbone.Model.extend
    defaults:
        position: 1

    initialize: () ->

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
    template: Templates.stub

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
        contents = $("<div class='contents'></div>")
        contents.append @template()
        @$el.html contents

        @pageSpecificRender()

        Fixes.iPhoneOverflowScroll @$el, contents
        @updatePosition()
        this

    # override this function in other pages
    pageSpecificRender: () ->
        return