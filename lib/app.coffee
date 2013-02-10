class View extends Backbone.View
  constructor: (options) ->
    @rows = options.rows

  render: ->
    $('<li/>').text(row.key).appendTo('#makes') for row in @rows

exports.App =
  class App
    constructor: (db) ->
      @name = name
      @db = db

    run: ->
      @db.getView 'bartender', 'showDocs', (err, data) ->
        if err
          return alert(err)
        view = new View({rows : data.rows})
        view.render()
