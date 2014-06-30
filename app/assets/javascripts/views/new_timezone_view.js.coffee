App.NewTimezoneView = Ember.View.extend
  templateName: 'new_timezone'
  tagName: 'form'

  submit: ->
    @get('controller').send('addTimezone', @get('name'), @get('city'), @get('gmt'))
    @set('name', '')
    @set('city', '')
    @set('gmt', 0)
    false