# for more details see: http://emberjs.com/guides/models/defining-models/

TimeZoneApp.Timezone = DS.Model.extend
  name: DS.attr 'string'
  city: DS.attr 'string'
  gmt: DS.attr 'number'
