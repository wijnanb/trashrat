window.App = Backbone.Model.extend
    defaults:
        startup_hash: undefined

    initialize: ->
        _.bindAll this
        Fixes.IEConsole() # never put anything in front of this, it breaks windows phone 7.5

        @generateDeviceId()
        Fixes.detectPlatform()

        # no fixed header for the old and crappy platforms
        if config.platform is 'wp' or config.platform is 'android2'
            config.fixed_header = false
        else
            config.fixed_header = true

        @onResize()
        $(window).on "resize", @onResize
        $(window).on 'orientationchange', @onRotate

        Fixes.backboneSuper()
        Fixes.fastClick()
        Fixes.preventWindowMovement()

        @set startup_hash: location.hash.substr(config.hash_characters.length)

        @startup()

        _.defer =>   # bootstrap with a deferred callback for window.app to be globally available
            @router = new Router()
            Backbone.history.start()

            @streetManager = new StreetManager

            @pageManager = new PageManager router: @router
            @pageManagerView = new PageManagerView
                model: @pageManager
                el: document.getElementById("pageManager")
            @pageManagerView.render()

            @openFirstPage()

    openFirstPage: ->
        last_position = Cache.readFromLocalStorage "last_position"
        startup_hash = @get('startup_hash')

        if startup_hash
            uri = startup_hash
        else
            unless last_position is false
                console.log "restored your last position"
                uri = last_position
            else
                uri = config.uri.intro.step1

        _.defer => @navigate uri

    navigate: (uri) ->
        @router.navigate uri, trigger: true

    onResize: ->
        window.screenWidth = $(document).width();
        window.screenHeight = if document.innerHeight then document.innerHeight else $(document).height()
        Fixes.adjustHeightToIPhoneStatusBar()

    onRotate: ->
        @repaint()

    generateDeviceId: ->
        device_id = localStorage["device-id"]

        unless device_id
            #generate unique GUID
            device_id = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
                r = Math.random()*16|0
                v = if c is 'x' then r else r&0x3|0x8
                return v.toString(16)

            console.log "created new device-id", device_id

            try
                localStorage.setItem "device-id", device_id
            catch error
                console.warn "localStorage not available", error

        config.device_id = device_id

    startup: () ->
        uri = config.uri.intro.step1
        document.location.hash = ""

        startupPage = uri
        config.pages = [startupPage]

    repaint: ->
        @onResize()
        @get('pageManagerView').render()




# Bootstrap application on jQuery/Zepto ready  (use deviceReady for PhoneGap)
$ ->
    window.app = new App()