config = require('./config.js').config
express = require 'express'
fs = require 'fs'
path = require 'path'
eco = require 'eco'
nodeio = require 'node.io'
log4js = require 'log4js'
log4js.replaceConsole()

Ivago = require('./importer').Ivago

server = express()

server.configure ->
    server.use '/static', express.static path.join(__dirname, '/static')
    server.use express.bodyParser()
    server.use (req, res, next) ->
        res.header 'Access-Control-Allow-Origin', config.allowedDomains
        res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
        res.header 'Access-Control-Allow-Headers', 'Content-Type'
        next()

server.get '/list/ivago/:zone/:year/:month', (req, res, next) ->
    zone = req.params.zone
    year = parseInt req.params.year
    month = parseInt req.params.month

    today = new Date()
    current_month = today.getMonth()+1
    current_year = today.getFullYear()

    if month < current_month
        unless year is current_year+1
            res.send "you can't look up a date in the past or further than 1 year in the future", 400
    else
        unless year is current_year
            res.send "you can't look up a date in the past or further than 1 year in the future", 400


    url =  config.scraper.ivago.base_url + zone + "/" + month
    calendar =
        zone: zone
        year: year
        month: month
        pickups: []

    class Scraper extends nodeio.JobClass
        input: false
        run: ->
            @getHtml url, (err, $, data) =>
                if err
                    console.error err
                    res.send err, 500
                    return

                try
                    $(".month_left .ophaalkalender tr.fractions").each (el) ->
                        day = el.children.filter(".day").text

                        types = []
                        el.children.filter(".fractions").children.each (fraction) ->
                            types.push fraction.attribs.class

                        pickup =
                            day: day
                            types: types

                        calendar.pickups.push pickup
                catch error
                    console.error "not available: #{month}/#{year}"

                res.send calendar

    scraper = new Scraper({timeout:10})
    scraper.run()




server.get '/importer', (req, res, next) ->
    Importer.ivago.run()




console.log "http server running on port " + config.server_port
server.listen config.server_port