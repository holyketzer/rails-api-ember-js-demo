App.TimezonesIndexController = Ember.ArrayController.extend
  nameFilter: ''

  filterComputed: Em.computed 'content.@each', 'nameFilter', ->
    filter = @get('nameFilter')
    if filter.length == 0
      @get('content')
    else
      @get('content').filter (item) ->
        match = item.get('name').toLowerCase().indexOf(filter.toLowerCase()) > -1
        match ||= item.get('city').toLowerCase().indexOf(filter.toLowerCase()) > -1

  actions:
    clearFilter: -> @set('nameFilter', '')