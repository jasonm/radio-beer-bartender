{RfidScanView, RfidScansView, RfidScan, RfidScansCollection} = require('lib/rfid_scans')
{BeerView, BeersView, Beer, BeersCollection} = require('lib/beers')

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
    @setupTabs()

    @rootEl.find('#taps').html("<h1>TODO: Taps</h1>")
    @rootEl.find('#readers').html("<h1>TODO: Readers</h1>")

  setupTabs: =>
    @tabsEl = $('ul.nav') # TODO: inject

    setTab = (href) =>
      # TODO: pushstate or routes or something
      document.location.hash = href
      @rootEl.find('>div').hide()
      @rootEl.find(href).show()

      @tabsEl.find('li').removeClass('active')
      @tabsEl.find("li a[href=#{href}]").closest('li').addClass('active')

    @navEl.find('a').click (e) =>
      setTab $(e.currentTarget).attr('href')
      e.preventDefault()

    setTab(document.location.hash)

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

exports.App = App
