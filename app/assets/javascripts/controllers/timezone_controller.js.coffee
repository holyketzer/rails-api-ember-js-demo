App.TimezoneController = Ember.ObjectController.extend
  actions:
    removeTimezone: ->
      timezone = @get('model')
      if confirm("Are you sure to delete timesone '#{timezone.get('name')}'?")
        timezone.destroyRecord();