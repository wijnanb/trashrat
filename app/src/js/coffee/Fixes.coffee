window.Fixes = (->

    statusBarHeight = 0
    headerHeight = 59

    return public_functions =

        detectPlatform: ->
            window.config.platform =
                if navigator.userAgent.match(/android 4/i) then "android4"
                else if navigator.userAgent.match(/android (2|3)/i) then "android2"
                else if navigator.userAgent.match(/(ipod|ipad|iphone)/i) then "ios"
                else if navigator.userAgent.match(/(IEMobile|MSIE)/i) then "wp"
                else "desktop"

            # detect IE
            if navigator.appName is 'Microsoft Internet Explorer'
                window.config.browser = "IE"
                re  = new RegExp "MSIE ([0-9]{1,}[\.0-9]{0,})"
                if re.exec(navigator.userAgent) != null
                     window.config.browser_version = parseFloat RegExp.$1

            window.config.headers =
                OS_TYPE: navigator.platform
                APP_VERSION: config.version
                DEVICE: navigator.appCodeName + " " + navigator.appName + " " + navigator.vendor
                DEVICE_ID: config.device_id
                OS_VERSION: navigator.userAgent

            console.log "platform", config.platform, config.browser, config.browser_version, config.headers

            className = if window.mozInnerScreenX? then "desktop firefox" else config.platform
            $("body").addClass className

        isFirefox: ->
            window.mozInnerScreenX?

        backboneSuper: ->
            Backbone.Model.prototype._super = (funcName) ->
                return this.constructor.__super__[funcName].apply this, _.rest(arguments)

        fastClick: ->
            ###
            Remove click delay on mobile wekkit
            ###
            unless config.platform is 'wp'
                if FastClick?
                    new FastClick(document.body)

        preventWindowMovement: ->
            ###
            Prevent bouncing of browser window. Add a class "fixed" for all the elements that should not be moved and are causing trouble with scrolling
            E.g.:  headers and footers
            ###
            $("input, textarea, .fixed").on 'touchmove', (event) =>
                event.preventDefault()


        adjustHeightToIPhoneStatusBar: ->
            ###
            On an iPhone you must set height in pixels for iPhone bounce issues
            ###

            if config.fixed_header
                $("#app").css "height", (window.screenHeight-statusBarHeight) + "px"
                $("#pageManager").css "height", (window.screenHeight-statusBarHeight-headerHeight) + "px"


        iPhoneOverflowScroll: (pageElement, contentsElement) ->
            ###
            Fix scrolling issues for iPhone when using overflow:scroll
            ###

            unless config.platform is 'desktop'
                if config.fixed_header && ScrollFix?
                    new ScrollFix pageElement.get(0)
                    pageElement.css "height", (window.screenHeight-statusBarHeight-headerHeight) + "px"
                    contentsElement.css "min-height", (window.screenHeight-statusBarHeight-headerHeight+1) + "px"



        AndroidHistoryFix: () ->
            ###
            Fix Backbone.History for cheap android phones
            ###
            $(document).on 'click', (event) ->
                element = if event.target.nodeName is "A" then event.target else $(event.target).parents("a").get(0)

                if element
                    uri = element.hash.substr(1)
                    app.navigate(uri)

                event.preventDefault()


        IEConsole: () ->
            ###
            Fix for IE not supporting console
            ###
            if typeof console is "undefined"
                window.console =
                    log: ->
                    warn: ->
                    error: ->


        polyfillPlaceholders: (element) ->
            if config.platform is 'wp' #placeholder fallback for IE
                input_focus = (event) ->
                    input = $(this)
                    if input.val() is input.attr 'placeholder'
                        input.val ''
                        input.removeClass 'empty'

                input_blur = (event) ->
                    input = $(this)
                    if input.val() is ''
                        input.val input.attr 'placeholder'
                        input.addClass 'empty'

                _.delay =>
                    inputs = element.find 'input[placeholder], textarea[placeholder]'

                    for input in inputs
                        unless holder?
                            input = $(input)
                            input.val input.attr 'placeholder'
                            input.addClass 'empty'
                            input.on 'focus', input_focus
                            input.on 'blur', input_blur
                , 500 # wait for rendering to be finished on windows phone


        getInputValuePlaceholderFix: (input) ->
            if input.val() is input.attr 'placeholder' then '' else input.val()


)()