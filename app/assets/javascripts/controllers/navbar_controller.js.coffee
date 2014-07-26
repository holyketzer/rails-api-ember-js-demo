App.NavbarController = Ember.ObjectController.extend
  needs: ['auth']
  isAuthenticated: Em.computed.alias 'controllers.auth.isAuthenticated'
  currentUserEmail: Em.computed.alias 'controllers.auth.email'
  actions:
    logout: -> @get('controllers.auth').logout()