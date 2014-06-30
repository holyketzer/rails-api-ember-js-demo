App.TimezonesController = Ember.ArrayController.extend
  addTimezone: (name, city, gmt)->
    timezone = this.store.createRecord('timezone', name: name, city: city, gmt: gmt)
    timezone.save()