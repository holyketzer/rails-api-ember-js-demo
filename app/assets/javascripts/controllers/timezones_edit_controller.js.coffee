App.TimezonesEditController = Ember.ObjectController.extend
  updateItem: (timezone) ->
    timezone.save()
    @get('target').transitionTo('timezones')

  isNew: Em.computed ->
    !@get('content').get('id')
  .property('id')