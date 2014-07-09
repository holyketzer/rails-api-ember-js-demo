App.initApp = (currentUser) ->
  App.__container__.lookup('controller:auth').set 'currentUser', currentUser

App.authorize = (route) ->
  route.transitionTo 'login' unless route.controllerFor('auth').get('isAuthenticated')