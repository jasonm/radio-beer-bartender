{RfidScansView, RfidScansCollection} = require('lib/rfid_scans')
{BeersView, BeersCollection} = require('lib/beers')
{TapsView, TapsCollection} = require('lib/taps')
{ReadersView, ReadersCollection} = require('lib/readers')
{Router} = require('lib/router')

class App
  constructor: (dbName, appName, rootEl, navEl) ->
    Backbone.couch_connector.config.collection_field_identifier = 'type'
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.global_changes = false
    @rootEl = rootEl
    @navEl = navEl

  run: =>
    @setupScans()
    @setupBeers()
    @setupTaps()
    @setupReaders()
    @router = new Router(@rootEl)
    Backbone.history.start()

  setupScans: =>
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.find('#region-scans').append(view.$el)
    collection.fetch()

  setupBeers: =>
    collection = new BeersCollection()
    view = new BeersView({ collection: collection })
    @rootEl.find('#region-beers').append(view.$el)
    collection.fetch()

  setupTaps: =>
    collection = new TapsCollection()
    view = new TapsView({ collection: collection })
    @rootEl.find('#region-taps').append(view.$el)
    collection.fetch()

  setupReaders: =>
    collection = new ReadersCollection()
    view = new ReadersView({ collection: collection })
    @rootEl.find('#region-readers').append(view.$el)
    collection.fetch({ group: true })

exports.App = App
