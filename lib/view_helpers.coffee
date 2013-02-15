Handlebars = require('handlebars')

Handlebars.registerHelper 'calendarTime', (date) ->
  moment(date).calendar()
