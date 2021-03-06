window.Pickup = Backbone.Model.extend
    defaults:
        date: undefined
        types: undefined
        sector: undefined
       

    initialize: ->

    parse: (response, options) ->
        date = new Date(response.datum.replace(/(\d{2})\/(\d{2})\/(\d{4})/,'$3-$2-$1 0:00:00'))
        
        types = []
        response.fractie.split('/').forEach (t) =>
            # papier & karton -> papier
            if t is 'Papier & karton ' then t = 'Papier'

            # remove spaces
            t = t.split(' ').join('')

            types.push t

        return attributes =
            date: date
            types: types
            sector: response.locatie

window.PickupCollection = Backbone.Collection.extend
    url: "data/ivago/inzamelkalender.json"
    sortBy: (element) -> element.get('date')
    initialize: ->
        @fetch()
        @on 'sync', => 
            console.log("ivago calendar synced")
            @trigger 'ready'

    countTypes: ->
        types = {}
        @each (element) -> 
            element.get('types').forEach (t) -> 
                if types[t]? then types[t] += 1 else types[t] = 0
        return types

    parse: (response, options) ->
        results = []
        response["IVAGO-Inzamelkalender"].forEach (element) => 
            results.push Pickup.prototype.parse(element)
        return results