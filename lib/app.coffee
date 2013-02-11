class RfidScansView extends Backbone.View
  tagName: 'ul'

  initialize: (options) ->
    @collection = options.collection
    @listenTo(@collection, 'reset', @render)
    @listenTo(@collection, 'add', @render)
    @listenTo(@collection, 'remove', @render)

  render: =>
    @$el.empty()
    $('<li/>').text(JSON.stringify(scan.attributes)).appendTo(@el) for scan in @collection.models

class RfidScan extends Backbone.Model

class RfidScansCollection extends Backbone.Collection
  db:
    changes: true
  model: RfidScan
  url: '/rfid-scan'

class App
  constructor: (dbName, appName, rootEl) ->
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.global_changes = false
    @rootEl = rootEl

  run: ->
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.append(view.$el)
    collection.fetch()

exports.App = App
