# For more information see: http://emberjs.com/guides/routing/

TimeZoneApp.Router.map ()->
  # @resource('posts')
  @route 'timezones', path: '/'

TimeZoneApp.TimezonesRoute = Ember.Route.extend
  setupController: (controller) -> controller.set('content', [])