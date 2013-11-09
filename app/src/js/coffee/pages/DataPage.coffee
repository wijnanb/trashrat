window.DataPage = Page.extend {}
    
window.DataPageView = PageView.extend
    className: "data page"
    template: Templates.data
    
    pageSpecificRender: () ->
        _.bindAll this
        @next = @$el.find('.next')
        @next.on 'click', @nextPage

    nextPage: -> 
        app.navigate('street')
        document.location.reload()

    contextForTemplate: () ->
        return app.toJSON()
       


        
