Handlebars = require('handlebars')

Handlebars.registerHelper 'calendarTime', (date) ->
  moment(date).calendar()


Handlebars.registerHelper 'toJSON', (object) ->
  JSON.stringify(object)
