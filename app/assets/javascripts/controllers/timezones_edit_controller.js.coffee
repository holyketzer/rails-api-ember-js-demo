App.TimezonesEditController = Ember.ObjectController.extend
  actions:
    updateItem: (timezone) ->
      timezone.save().then(
        => @transitionToRoute('timezones')
        (response) ->
      )
      #@get('target').transitionTo('timezones')

  isNew: Em.computed ->
    !@get('content').get('id')
  .property('id')

  removeRecordIfEmpty: -> @content.deleteRecord() if @get('isNew')
