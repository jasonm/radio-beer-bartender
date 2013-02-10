
exports.App =
  class App
    constructor: (db) ->
      @name = name

      db.getView 'bartender', 'showDocs', (err, data) ->
        if err
          return alert(err)

        $('<li/>').text(row.key).appendTo('#makes') for row in data.rows
