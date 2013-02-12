class Reader extends Backbone.Model

class ReadersCollection extends Backbone.Collection
  db:
    changes: true
    view: 'distinctReadersFromRfidScans'
  model: Reader

class ReaderView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: 'readers/show.html'
  modelEvents:
    "change": "render"

class ReadersView extends Backbone.Marionette.CollectionView
  itemView: ReaderView
  tagName: 'ul'

_.extend(exports, {ReaderView, ReadersView, Reader, ReadersCollection})
