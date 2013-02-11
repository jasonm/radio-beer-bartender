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
  constructor: (dbName, appName, rootEl, navEl) ->
    Backbone.couch_connector.config.db_name = dbName
    Backbone.couch_connector.config.ddoc_name = appName
    Backbone.couch_connector.config.global_changes = false
    @rootEl = rootEl
    @navEl = navEl

  run: =>
    @setupScans()
    @navEl.find('a').click (e) =>
      target = $(e.currentTarget)

      @rootEl.find('>div').hide()
      target.closest('ul').find('li').removeClass('active')

      target.closest('li').addClass('active')
      @rootEl.find(target.attr('href')).show()

      e.preventDefault()

  setupScans: =>
    collection = new RfidScansCollection()
    view = new RfidScansView({ collection: collection })
    @rootEl.find('#scans').append(view.$el)
    collection.fetch()

exports.App = App
