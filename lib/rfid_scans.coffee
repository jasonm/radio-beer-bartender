class RfidScan extends Backbone.Model

class RfidScansCollection extends Backbone.Collection
  db:
    changes: true
    view: 'rfidScansByCreatedAtDesc'
  model: RfidScan

class RfidScanView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: 'rfidscan/show.html'
  modelEvents:
    "change": "render"

class RfidScansView extends Backbone.Marionette.CollectionView
  itemView: RfidScanView
  tagName: 'ul'

_.extend(exports, {RfidScanView, RfidScansView, RfidScan, RfidScansCollection})
