#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require timezone_app
#= require bootstrap-sprockets
#= require moment

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create()

App.reopen
  currentPath: ''
  isMainPage: Ember.computed 'currentPath', -> @get('currentPath') == 'timezones.index'

App.urls ||= {}
App.urls.login = '/oauth/token'
App.urls.register = '/users.json'
App.urls.logout = '/users/sign_out.json'