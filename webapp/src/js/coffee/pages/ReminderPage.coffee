window.ReminderPage = Page.extend {}
    
window.ReminderPageView = PageView.extend
    className: "reminder page"
    template: Templates.reminder

    pageSpecificRender: () ->
        _.bindAll this
        @option_0 = @$el.find('.option-0')
        @option_1 = @$el.find('.option-1')
        @timepicker = @$el.find('.timepicker')
        @next = @$el.find('.next')

        @option_0.on 'click', =>
            @option_0.addClass "selected"
            @option_1.removeClass "selected"

        @option_1.on 'click', =>
            @option_1.addClass "selected"
            @option_0.removeClass "selected"

        @next.on 'click', @nextPage

    nextPage: ->
        app.set
            reminder: 
                day: if @option_0.hasClass("selected") then "on_day" else "previous_day"
                time: @timepicker.val()

        app.navigate('data')


        
