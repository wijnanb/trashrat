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

        debugger
        @container.empty()
        items = []

        for pickup in @pickups
            for t in pickup.get('types')
                if t.substr(-1) is " " then t = t.substr(0,t.length-1)

            console.log pickup.toJSON()

            item = Templates.pickup
                day: days[pickup.get('date').getDay()]
                date: pickup.get('date').getDate() + "/" + (pickup.get('date').getMonth()+1)
                types: pickup.get('types')
            items.push item

        @container.append items


    contextForTemplate: () ->
        return app.toJSON()
       


        
