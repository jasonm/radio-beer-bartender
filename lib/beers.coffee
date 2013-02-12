{StatefulItemView} = require 'lib/stateful_item_view'

class BeerView extends StatefulItemView
  tagName: 'li'
  className: 'beer'
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
    "beers/#{@state}.html"

class NewBeerView extends StatefulItemView
  tagName: 'li'
  className: 'beer-new'
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
    "beers/#{@state}.html"

class BeersView extends Backbone.Marionette.CollectionView
  itemView: BeerView
  tagName: 'ul'
  className: 'unstyled'

  onRender: =>
    @newView = new NewBeerView({@collection})
    @newView.render()
    @$el.prepend @newView.el

class Beer extends Backbone.Model
  schema:
    name: 'Text'
    abv: 'Text'
    description: 'Text'

class BeersCollection extends Backbone.Collection
  db:
    changes: true
  model: Beer
  url: '/beer'

_.extend(exports, {BeerView, BeersView, Beer, BeersCollection})
