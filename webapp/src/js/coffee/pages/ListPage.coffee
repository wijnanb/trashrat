window.ListPage = Page.extend {}
    
window.ListPageView = PageView.extend
    className: "list page"
    template: Templates.list
    
    pageSpecificRender: () ->
        _.bindAll this

        @app.get('street')
        

    contextForTemplate: () ->
        return app.toJSON()
       


        
