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

class BeersView extends Backbone.Marionette.CollectionView
  itemView: BeerView
  tagName: 'ul'

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
