window.Street = Backbone.Model.extend
    defaults:
        street: undefined
        code: undefined
        sector: undefined
        provider: undefined
        zip: undefined #string
        place: undefined

    initialize: ->

    parse: (response, options) ->
        return attributes =
            street: response.straatnaam
            code: response.straatcode
            sector: response.sector
            provider: "ivago"
            zip: response.postcode
            place: response.gemeente
        # "even van"
        # "even tot"
        # "oneven van "
        # "oneven tot"

window.IvagoStreetCollection = Backbone.Collection.extend
    url: "data/ivago/stratenlijst.json"
    initialize: ->
        @fetch()
        @on 'sync', => 
            console.log("ivago streets synced")
            @trigger 'ready'

    parse: (response, options) ->
        results = []
        response["IVAGO-Stratenlijst"].forEach (element) => results.push Street.prototype.parse(element)
        return results


window.StreetManager = Backbone.Model.extend
    initialize: ->
        @streets = new IvagoStreetCollection
        @streets.on 'ready', =>
            @pickups = new PickupCollection
            @pickups.on 'ready', =>
                @trigger 'ready'

    findStreetsWith: (query, zip) ->
        if zip
            streets = @streets.where zip:zip
        else
            streets = @streets

        results = streets.filter (element) =>
            element.get('street').toLowerCase().indexOf(query.toLowerCase()) isnt -1
        
        return results

    getPickupsForSector: (sector) ->
        today = +new Date()
        _.filter @pickups.where({sector:sector}), (p) -> +p.get('date') >= today
        
