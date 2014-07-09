App.AuthController = Ember.ObjectController.extend
  currentUser:  null
  isAuthenticated: Em.computed.notEmpty('currentUser.email')
  login: (route) ->
    me = @
    $.ajax
      url: App.urls.login
      type: 'POST'
      data:
        'user[email]': route.currentModel.email
        'user[password]': route.currentModel.password
      success: (data) ->
        me.set 'currentUser', data.user
        route.transitionTo '/'
      error: (jqXHR, textStatus, errorThrown) ->
        if jqXHR.status == 401
          route.controllerFor('login').set 'errorMsg', "That email/password combo didn't work.  Please try again"
        else if jqXHR.status == 406
          route.controllerFor('login').set 'errorMsg', 'Request not acceptable (406):  make sure Devise responds to JSON.'
        else
          alert "Login Error: #{jqXHR.status} | #{errorThrown}"

  register: (route) ->
    me = @
    $.ajax
      url: App.urls.register
      type: 'POST'
      data:
      #would be nice if could do something like this
      #user: @currentModel.getJSON
      #(perhaps there is, but couldn't find)
        'user[name]': route.currentModel.name
        'user[email]': route.currentModel.email
        'user[password]': route.currentModel.password
        'user[password_confirmation]': route.currentModel.password_confirmation
      success: (data) ->
        me.set 'currentUser', data.user
        route.transitionTo '/'
      error: (jqXHR, textStatus, errorThrown) ->
        if jqXHR.status == 422
          route.currentModel.set('isValid', false)
          route.currentModel.set('errors', jqXHR.responseJSON.errors)
        else
          route.controllerFor('registration').set 'errorMsg', "That email/password combo didn't work.  Please try again"

  logout: ->
    me = @
    $.ajax
      url: App.urls.logout
      type: 'DELETE'
      dataType: 'json'
      success: (data, textStatus, jqXHR) ->
        $('meta[name="csrf-token"]').attr('content', data['csrf-token'])
        $('meta[name="csrf-param"]').attr('content', data['csrf-param'])
        me.set 'currentUser', null
        me.transitionToRoute 'about'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error logging out: #{errorThrown}"