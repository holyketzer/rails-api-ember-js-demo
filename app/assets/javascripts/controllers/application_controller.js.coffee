App.ApplicationController = Ember.Controller.extend
  updateCurrentPath: Ember.observer 'currentPath', ->
    App.set('currentPath', @get('currentPath'))