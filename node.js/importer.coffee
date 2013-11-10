


##################
# Download all the Ivago data (regio Gent)
#
exports.Ivago = class Ivago
    constructor: () ->
    run: ->
        urls =
            calendar: "http://datatank.gent.be/MilieuEnNatuur/IVAGO-Inzamelkalender.json"
            streets: "http://datatank.gent.be/MilieuEnNatuur/IVAGO-Stratenlijst.json"
            appartments: "http://datatank.gent.be/MilieuEnNatuur/IVAGO-Appartementen.json"

        http.get(urls.appartments, (res) ->
            console.log "GET " + urls.appartments, res.statusCode
        ).on 'error', (error) ->
            console.error e.message