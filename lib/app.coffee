{RfidScanView, RfidScansView, RfidScan, RfidScansCollection} = require('lib/rfid_scans')
{BeerView, BeersView, Beer, BeersCollection} = require('lib/beers')

class Router extends Backbone.Router
  initialize: (rootEl) =>
    @rootEl = rootEl
    @tabsEl = $('ul.nav') # TODO: inject

  routes:
    '': 'home'
    'home': 'showHash'
    'taps': 'showHash'
    'beers': 'showHash'
    'readers': 'showHash'
    'scans': 'showHash'

  showTab: (tab) =>
    @rootEl.find('>div').hide()
    @rootEl.find("##{tab}").show()

    @tabsEl.find('li').removeClass('active')
    @tabsEl.find("li a[href=##{tab}]").closest('li').addClass('active')

  home: =>
    @showTab 'home'

  showHash: =>
    @showTab document.location.hash.replace('#', '')

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
    @setupBlanks()
    @router = new Router(@rootEl)
    Backbone.history.start()

  setupScans: =>
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.find('#scans').append(view.$el)
    collection.fetch()

  setupBeers: =>
    collection = new BeersCollection()
    view = new BeersView({ collection: collection })
    @rootEl.find('#beers').append(view.$el)
    collection.fetch()

  setupBlanks: =>
    @rootEl.find('#taps').html("<h1>TODO: Taps</h1>")
    @rootEl.find('#readers').html("<h1>TODO: Readers</h1>")

exports.App = App
