# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @route 'about'
  @route 'login'
  @route 'registration'
  @resource 'timezones', path: '/', ->
    @route 'new'
    @route 'edit', path: ':timezone_id'

App.TimezonesRoute = Ember.Route.extend
  model: -> this.store.find('timezone')
  renderTemplate: -> into:'application'

App.TimezonesNewRoute = Ember.Route.extend
  setupController: (controller, model) ->
    timezone = @store.createRecord('timezone', {})
    @controllerFor('timezones.edit').setProperties(content: timezone)

  renderTemplate: -> @render 'timezones.edit', into: 'application'

  actions:
    willTransition: (transition) ->
      @controllerFor('timezones.edit').removeRecordIfEmpty()
      true

App.TimezonesEditRoute = Ember.Route.extend
  actions:
    willTransition: (transition) ->
      @controllerFor('timezones.edit').cancelChangesIfDirty()
      true

App.LoginRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  setupController: (controller, model) ->
    controller.set 'content', model
    controller.set 'errorMsg', ''
  actions:
    login: -> @controllerFor('auth').login this
    cancel: -> @transitionTo '/'

App.RegistrationRoute = Ember.Route.extend
  model: -> Ember.Object.create({isValid: true, password: '', password_confirmation: ''})
  actions:
    register: -> @controllerFor('auth').register this
    cancel: -> @transitionTo '/'