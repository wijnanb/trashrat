window.ListPage = Page.extend {}
    
window.ListPageView = PageView.extend
    className: "list page"
    template: Templates.list
    
    pageSpecificRender: () ->
        _.bindAll this

        @container = @$el.find('.container')

        days = ['Zondag', 'Maandag','Dinsdag', 'Woensdag', 'Donderdag', 'Vrijdag', 'Zaterdag']

        sector = app.get('street').sector
        @pickups = app.streetManager.getPickupsForSector(sector)

        @container.empty()
        items = []

        for pickup, index in @pickups
            item = Templates.pickup
                day: days[pickup.get('date').getDay()]
                date: pickup.get('date').getDate() + "/" + (pickup.get('date').getMonth()+1)
                types: pickup.get('types')
                color: "color-" + (index % 4)
            items.push item

        @container.append items


    contextForTemplate: () ->
        return app.toJSON()
       


        
