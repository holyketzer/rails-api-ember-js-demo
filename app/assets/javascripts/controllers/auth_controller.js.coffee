App.AuthController = Ember.ObjectController.extend
  email:  null
  accessToken: null
  isAuthenticated: Em.computed.notEmpty('email')

  authorize: (email, token) ->
    @set 'email', email
    @set 'accessToken', token
    $.ajaxSetup(headers: { 'Authorization': "Basic #{window.btoa(token)}" })

  unauthorize: -> @authorize(null, null)

  login: (route) ->
    me = @
    $.ajax
      url: App.urls.login
      type: 'POST'
      data:
        'username': route.currentModel.email
        'password': route.currentModel.password
        'grant_type': 'password'
      email: route.currentModel.email
      success: (data) ->
        me.authorize(@email, data.access_token)
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
        'user[email]': route.currentModel.email
        'user[password]': route.currentModel.password
        'user[password_confirmation]': route.currentModel.password_confirmation
      success: (data) ->
        me.login(route)
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
        $.ajaxSetup(headers: { })
        me.unauthorize()
        me.transitionToRoute 'about'
        me.store.unloadAll('timezone')
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error logging out: #{errorThrown}"