window.StreetPage = Page.extend {}
    
window.StreetPageView = PageView.extend
    className: "street page"
    template: Templates.street

    pageSpecificRender: () ->
        screen_height = 480

        @modal = @$el.find('#street-search-modal');
        @modal.css "-webkit-transform", "translate3d(0px,#{screen_height}px,0px)"
        
        @searchbox = @modal.find('input.searchbox');
        @searchresults = @modal.find('.results');

        @$el.find("#street-button").on 'click', (event) =>
            @modal.show()
            _.defer =>
                @modal.css "-transition", "-webkit-transform 400ms"
                @modal.css "-webkit-transform", "translate3d(0px,0px,0px)"

                @searchbox.on 'keyup', @updateAutoComplete

                _.delay => @searchbox.focus()

    updateAutoComplete: () ->
        query = @searchbox.val()
        console.log query

        @searchresults.empty()

        results = ['Aaigemstraat', 'Pelikaanstraat', 'Kleindokkaai']
        
        for result in results
            do (result) =>
                item = $ Templates.street_result
                    street: result
                item.on 'click', => @selectStreet(result)
                @searchresults.append item

    selectStreet: (street) ->
        console.log "select #{street}"

                

        
