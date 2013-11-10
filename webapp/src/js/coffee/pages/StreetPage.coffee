window.StreetPage = Page.extend {}
    #default: selectedStreet
    
window.StreetPageView = PageView.extend
    className: "street page"
    template: Templates.street

    contextForTemplate: () ->
        return app.toJSON()

    pageSpecificRender: () ->
        _.bindAll this
        @page_height = window.screenHeight

        @zip_field = @$el.find('.zip-field')
        @street_button = @$el.find(".street-button")
        @nr_field = @$el.find('.nr-field')
        @next = @$el.find('.next')

        @modal = @$el.find('#street-search-modal');
        @modal.css "-webkit-transform", "translate3d(0px,#{@page_height}px,0px)"
        
        @searchbox = @modal.find('.searchbox input');
        @searchbox.on 'keyup', _.debounce(@updateAutoComplete, 150)
        @searchresults = @modal.find('.results');

        @street_button.on 'keydown', (event) => event.preventDefault()
        @street_button.on 'focus', (event) =>
            event.preventDefault()
            @street_button.blur()
            _.delay =>
                @modal.show()
                @$el.scrollTop(0)
                _.defer =>
                    @modal.css "-webkit-transform", "translate3d(0px,0px,0px)"
                    @modal.css "opacity", "1"
                    @searchbox.focus()
                    @$el.scrollTop(0)
            , 0

        @zip_field.on 'change keyup', (event) => @updateEnabledFields()
        @street_button.on 'change keyup', (event) => @updateEnabledFields()
        @nr_field.on 'change keyup', (event) => @updateEnabledFields()

        @model.on 'change:selectedStreet', => 
            @updateEnabledFields()
            @street_button.val @model.get('selectedStreet').street
        @model.set selectedStreet: app.get('street')

        @next.on 'click', => @nextPage()

        @updateEnabledFields()

    updateAutoComplete: () ->
        query = @searchbox.val()
        console.log query

        @searchresults.empty()

        # only search for more than one character
        if query.length < 2
            return

        zip = if @zip_field.val()?.length is 4 then @zip_field.val() else undefined
        console.log("zip", zip)
        results = app.streetManager.findStreetsWith(query, zip)
        
        if results.length > 0
            items = []
            for result in results
                do (result) =>
                    item = $ Templates.street_result
                        street: result.get('street')
                    item.on 'click', => @selectStreet(result)
                    items.push item
            @searchresults.append items
        else
            @searchresults.append Templates.no_results
                zip: zip

    selectStreet: (street) ->
        console.log "select #{street.get('street')}"

        @model.set
            selectedStreet: street.toJSON()

        @modal.css "-webkit-transform", "translate3d(0px,#{@page_height}px,0px)"
        @modal.css "opacity", "0"

        _.delay =>
            # reset modal
            @modal.hide()
            @searchbox.val('')
            @updateAutoComplete()
        , 400

    updateEnabledFields: ->
        @zip_field.removeAttr 'disabled'
        @zip_field.removeClass 'disabled'

        if @zip_field.val()
            @street_button.removeAttr 'disabled'
            @street_button.removeClass 'disabled'
        else
            @street_button.prop 'disabled', 'disabled'
            @street_button.addClass 'disabled'

        if @zip_field.val() and @model.get('selectedStreet')?
            @nr_field.removeAttr 'disabled'
            @nr_field.removeClass 'disabled'
        else
            @nr_field.prop 'disabled', 'disabled'
            @nr_field.addClass 'disabled'

    nextPage: ->
        if @model.get('selectedStreet')? and @nr_field.val() != ""
            street = @model.get('selectedStreet')
            street.nr = @nr_field.val()

            app.set
                street: street

            app.navigate('reminder')
        else
            console.error("form not filled in")
                    
       

                

        
