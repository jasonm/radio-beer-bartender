class RfidScanView extends Backbone.View
  tagName: 'li'

  initialize: (options) ->
    @listenTo(@model, 'change', @render)

  render: =>
    @$el.empty()
    @$el.html("#{@model.get('created_at')} - scanned #{@model.get('tag_id')} at #{@model.get('reader_description')}")

class RfidScansView extends Backbone.Marionette.CollectionView
  itemView: RfidScanView
  tagName: 'ul'

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
