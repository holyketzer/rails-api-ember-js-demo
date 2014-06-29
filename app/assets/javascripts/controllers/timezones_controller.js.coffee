TimeZoneApp.TimezonesController = Ember.ArrayController.extend
  addTimezone: ->
    @pushObject Ember.Object.create(name: @get('name'), city: @get('city'), gmt: @get('gmt'))
    @set('name', '')
    @set('city', '')
    @set('gmt', 0)
