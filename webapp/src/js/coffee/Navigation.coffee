window.NavigationView = Backbone.View.extend
    initialize: ->
        @settings = @$el.find('.settings')
        @settings.on 'click', => app.navigate('street')
