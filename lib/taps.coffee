{StatefulItemView} = require 'lib/stateful_item_view'
{NewTappingView, Tapping, TappingsCollection} = require 'lib/tappings'

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

  initialize: =>
    @on 'change:state', @onChangeState

  save: (e) =>
    e.preventDefault() if e
    @model.once 'change', =>
      @$('i.changed').show().fadeOut(1000)
    @model.set(Backbone.Syphon.serialize(@))
    @model.save()
    @setState 'show'

  onRender: =>
    @$('[data-toggle=tooltip]').tooltip({})

  serializeData: ->
    beers = window.app.collections.beers

    _.extend @model.toJSON(),
      started_at: moment(@model.attributes.started_at).format("YYYY-MM-DD HH:mm:ss")
      finished_at: moment(@model.attributes.finished_at).format("YYYY-MM-DD HH:mm:ss")
      beers: beers.toJSON()
      tappings: _.map(@model.get('tappings').toJSON(), (tappingAttributes) ->
        _.extend tappingAttributes,
          beer: beers.get(tappingAttributes.beer_id)?.toJSON()
      )

  onChangeState: (state) =>
    # TODO: This should clearly be its own view class, extract.
    if state == 'on-tap'
      @newTappingView = new NewTappingView
        tap: @model
        model: new Tapping()
        el: @$('.new-tapping')
      @newTappingView.render()
      @listenTo @newTappingView, 'saved', @save

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

class Tap extends Backbone.RelationalModel
  relations: [
    {
      type: Backbone.HasMany,
      key: 'tappings',
      relatedModel: Tapping,
      collectionType: TappingsCollection
      reverseRelation: {
        key: 'tap'
      }
    }
  ]

Tap.setup()

class TapsCollection extends Backbone.Collection
  db:
    changes: true
  model: Tap
  url: '/tap'

_.extend(exports, {TapView, TapsView, Tap, TapsCollection})
