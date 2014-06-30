# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @route 'timezones', path: '/'

App.TimezonesRoute = Ember.Route.extend
  model: -> this.store.find('timezone')