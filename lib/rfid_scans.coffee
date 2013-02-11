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

_.extend(exports, {RfidScanView, RfidScansView, RfidScan, RfidScansCollection})
