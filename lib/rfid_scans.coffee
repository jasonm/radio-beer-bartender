class RfidScan extends Backbone.Model

class RfidScansCollection extends Backbone.Collection
  db:
    changes: true
  model: RfidScan
  url: '/rfid-scan'

class RfidScanView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: 'rfidscan/show.html'
  modelEvents:
    "change": "render"

class RfidScansView extends Backbone.Marionette.CollectionView
  itemView: RfidScanView
  tagName: 'ul'

_.extend(exports, {RfidScanView, RfidScansView, RfidScan, RfidScansCollection})
