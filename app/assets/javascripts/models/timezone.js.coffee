# for more details see: http://emberjs.com/guides/models/defining-models/

App.Timezone = DS.Model.extend
  name: DS.attr 'string'
  city: DS.attr 'string'
  gmt: DS.attr 'number', defaultValue: -> 0

  gmtFormatted: Em.computed 'gmt', -> App.formatGmt @get('gmt')