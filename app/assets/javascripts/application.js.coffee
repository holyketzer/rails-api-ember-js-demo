#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require timezone_app

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create()

App.urls ||= {}
App.urls.login = "/users/sign_in.json"
App.urls.register = "/users.json"
App.urls.logout = "/users/sign_out.json"