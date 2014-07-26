App.initApp = (currentUser) ->
  if currentUser.token
    App.__container__.lookup('controller:auth').authorize(currentUser.email, currentUser.token)

App.authorize = (route) ->
  route.transitionTo 'login' unless route.controllerFor('auth').get('isAuthenticated')

App.formatGmt = (gmt) ->
  sign = switch
    when gmt > 0 then '+'
    when gmt < 0 then '-'
    else ' '
  leadZero = if Math.abs(gmt) < 10 then '0' else ''
  "GMT #{sign}#{leadZero}#{Math.abs(gmt)}:00"