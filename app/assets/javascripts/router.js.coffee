# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'timezones', path: '/', ->
    @route 'new'
    @route 'edit', path: ':timezone_id'
    # @resource 'timezone', path: ':timezone_id'

# App.IndexRoute = Em.Route.extend
#   beforeModel: -> @transitionTo 'timezones'

App.TimezonesRoute = Ember.Route.extend
  model: -> this.store.find('timezone')
  renderTemplate: -> into:'application'

App.TimezonesNewRoute = Ember.Route.extend
  setupController: (controller, model) ->
    timezone = @store.createRecord('timezone', {})
    @controllerFor('timezones.edit').setProperties(content: timezone)

  renderTemplate: -> @render 'timezones.edit', into: 'application'

App.LocationsEditRoute = Ember.Route.extend
  setupController: (controller, model) ->
      @controllerFor('timezones.edit').setProperties(content: model)

  renderTemplate: -> @render 'timezones.edit', into: 'application'