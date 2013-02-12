{StatefulItemView} = require 'lib/stateful_item_view'

class TapView extends StatefulItemView
  tagName: 'li'
  className: 'tap'
  state:
    'show'
  events:
    'click button.btn-save': 'save'
    'click a.delete': 'promptToDelete'
  modelEvents:
    'change': 'render'

  save: (e) =>
    e.preventDefault()
    @model.once 'change', =>
      @$('i.changed').show().fadeOut(1000)
    @model.set(Backbone.Syphon.serialize(@))
    @model.save()
    @setState 'show'

  promptToDelete: (e) =>
    e.preventDefault()
    if confirm("Are you sure you want to delete #{@model.get('name')}?")
      @model.destroy()

  getTemplate: (data) ->
    "taps/#{@state}.html"

class NewTapView extends StatefulItemView
  tagName: 'li'
  className: 'tap-new'
  state:
    'prompt-new'

  events:
    'click button.btn-save': 'save'

  initialize: (options) =>
    @collection = options.collection

  save: (e) =>
    e.preventDefault()
    @collection.create(Backbone.Syphon.serialize(@))
    @setState 'prompt-new'

  getTemplate: (data) ->
    "taps/#{@state}.html"

class TapsView extends Backbone.Marionette.CollectionView
  itemView: TapView
  tagName: 'ul'
  className: 'unstyled'

  onRender: =>
    @newView = new NewTapView({@collection})
    @newView.render()
    @$el.prepend @newView.el

class Tap extends Backbone.Model
  schema:
    name: 'Text'
    abv: 'Text'
    description: 'Text'

class TapsCollection extends Backbone.Collection
  db:
    changes: true
  model: Tap
  url: '/tap'

_.extend(exports, {TapView, TapsView, Tap, TapsCollection})

