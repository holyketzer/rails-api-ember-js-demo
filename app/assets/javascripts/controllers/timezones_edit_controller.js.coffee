App.TimezonesEditController = Ember.ObjectController.extend
  actions:
    updateItem: (timezone) ->
      timezone.save().then(
        => @transitionToRoute('timezones')
        (response) ->
      )

  isNew: Em.computed ->
    !@get('content').get('id')
  .property('id')

  gmts: Em.computed -> { text: App.formatGmt(i), value: i } for i in [-12..12]

  removeRecordIfEmpty: -> @content.deleteRecord() if @get('isNew')

  cancelChangesIfDirty: -> @content.rollback() if @content.get('isDirty')
