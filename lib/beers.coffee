class BeerView extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'beer'
  modelEvents:
    'change': 'render'

  events:
    'click a.state-control': 'clickState'
    'click button.btn-save': 'save'

  initialize: ->
    @state = 'show'

  clickState: (e) =>
    e.preventDefault()
    @setState($(e.target).data('state'))

  setState: (state) =>
    @state = state
    @render()

  save: (e) =>
    e.preventDefault()
    @model.once 'change', =>
      @$('i.changed').show().fadeOut(1000)
    @model.set(Backbone.Syphon.serialize(@))
    @model.save()
    @setState 'show'

  getTemplate: (data) ->
    "beers/#{@state}.html"

class NewBeerView extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'beer-new'

  events:
    'click a.state-control': 'clickState'
    'click button.btn-save': 'save'

  initialize: (options) =>
    @state = 'prompt-new'
    @collection = options.collection

  clickState: (e) =>
    e.preventDefault()
    @setState($(e.target).data('state'))

  setState: (state) =>
    @state = state
    @render()

  save: (e) =>
    e.preventDefault()
    attrs = Backbone.Syphon.serialize(@)
    model = @collection.create(attrs)
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
