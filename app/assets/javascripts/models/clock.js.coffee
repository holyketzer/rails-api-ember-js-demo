ONE_SECOND = 1000

App.Clock = Ember.Object.extend
  second: null
  minute: null
  hour:   null

  init: -> @tick()

  tick: ->
    now = new Date()

    @setProperties
      second: now.getSeconds(),
      minute: now.getMinutes(),
      hour:   now.getHours()

    self = this
    setTimeout (-> self.tick()), ONE_SECOND

Ember.Application.initializer
  name: 'clock',
  initialize: (container, application) ->
    container.optionsForType('clock', singleton: true)
    container.register('clock:main', application.Clock)
    container.typeInjection('controller', 'clock', 'clock:main')


# don't break ObjectController
Ember.ControllerMixin.reopen(clock: null)