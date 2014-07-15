App.TimezoneController = Ember.ObjectController.extend
  actions:
    removeTimezone: ->
      timezone = @get('model')
      if confirm("Are you sure to delete timesone '#{timezone.get('name')}'?")
        timezone.destroyRecord()

  currentTime: Em.computed 'gmt', 'clock.second', -> moment().zone(-@get('gmt')).format('MMMM Do YYYY, hh:mm:ss a')

  htmlId: Em.computed 'id', -> "timezone-#{@get('id')}"