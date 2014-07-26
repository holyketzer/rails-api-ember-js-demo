App.initApp = (currentUser) ->
  App.__container__.lookup('controller:auth').set 'email', currentUser.email

App.authorize = (route) ->
  route.transitionTo 'login' unless route.controllerFor('auth').get('isAuthenticated')

App.formatGmt = (gmt) ->
  sign = switch
    when gmt > 0 then '+'
    when gmt < 0 then '-'
    else ' '
  leadZero = if Math.abs(gmt) < 10 then '0' else ''
  "GMT #{sign}#{leadZero}#{Math.abs(gmt)}:00"