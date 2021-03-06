{RfidScansView, RfidScansCollection} = require('lib/rfid_scans')
{BeersView, BeersCollection} = require('lib/beers')
{TapsView, TapsCollection} = require('lib/taps')
{ReadersView, ReadersCollection} = require('lib/readers')
{Router} = require('lib/router')
require 'lib/view_helpers'

class App
  constructor: (dbName, appName, rootEl, navEl) ->
    Backbone.couch_connector.config.collection_field_identifier = 'type'
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.single_feed = true
    @collections = {}
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
    @setup 'scans', RfidScansView, RfidScansCollection

  setupBeers: =>
    @setup 'beers', BeersView, BeersCollection

  setupTaps: =>
    @setup 'taps', TapsView, TapsCollection

  setupReaders: =>
    @setup 'readers', ReadersView, ReadersCollection

  setup: (regionName, viewType, collectionType, fetchOptions = {}) =>
    collection = new collectionType()
    collection.fetch(fetchOptions)
    @collections[regionName] = collection

    view = new viewType({ collection: collection })
    @rootEl.find("#region-#{regionName}").append(view.$el)

exports.App = App
