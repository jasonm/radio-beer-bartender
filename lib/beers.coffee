class BeerView extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'beer',
  template: 'beers/show.html'

class BeersView extends Backbone.Marionette.CollectionView
  itemView: BeerView
  tagName: 'ul'

class Beer extends Backbone.Model

class BeersCollection extends Backbone.Collection
  db:
    changes: true
  model: Beer
  url: '/beer'

_.extend(exports, {BeerView, BeersView, Beer, BeersCollection})

# class BeerShowView extends Backbone.Marionette.ItemView
#   className: 'show'
#
#   initialize: (options) ->
#     @model = options.model
#     @listenTo(@model, 'change', @render)
#
#   render: =>
#     @$el.empty()
#     @$el.html("#{@model.get('created_at')} - scanned #{@model.get('tag_id')} at #{@model.get('reader_description')}")
#
# class BeerEditView extends Backbone.View
#   className: 'edit'
#   initialize: (options) ->
#     @model = options.model
#     @listenTo(@model, 'change', @render)
#
#   render: =>
#     @$el.empty()
#     @$el.html("edit mode!")

# class BeerView extends Backbone.Marionette.CompositeView
#   tagName: 'li'
#   template: 'beers/show.html'
#
#   events:
#     'click .toggle': 'toggle'
#
#   initialize: (options) ->
#     @model = options.model
#     @showView = new BeerShowView({@model})
#     @editView = new BeerEditView({@model})
#     @children.add @showView
#     @children.add @editView
#
#   toggle: =>
#     @showView.$el.toggle()
#     @editView.$el.toggle()
#
#   onRender: =>
#     @showView.$el.show()
#     @editView.$el.hide()
