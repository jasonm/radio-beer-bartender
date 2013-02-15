class NewTappingView extends Backbone.Marionette.ItemView
  events:
    'click button.btn-save': 'save'

  template:
    'taps/new-tapping.html'

  initialize: (options) =>
    {@tap} = options

  onRender: =>
    @$('.date-time-picker').datetimepicker({ language: 'en-US' })
    @$('.chzn-select').chosen()

  serializeData: ->
    _.extend @model.toJSON(),
      started_at: moment(@model.attributes.started_at).format("YYYY-MM-DD HH:mm:ss")
      finished_at: moment(@model.attributes.finished_at).format("YYYY-MM-DD HH:mm:ss")
      beers: window.app.collections.beers.toJSON()

  save: (e) =>
    e.preventDefault()
    @model.set(Backbone.Syphon.serialize(@))
    @model.set('tap', @tap.id)
    # TODO provide Backbone.Syphon serializer for moment Dates
    @model.set('started_at', moment(@$('#inputStartedAt').val()).toString())
    @model.set('finished_at', moment(@$('#inputFinishedAt').val()).toString())
    @trigger 'saved'
    @model = new Tapping()

class Tapping extends Backbone.RelationalModel
  initialize: =>
    @started_at = new Date()
    @finished_at = new Date()

Tapping.setup()

class TappingsCollection extends Backbone.Collection
  model: Tapping

_.extend(exports, {NewTappingView, Tapping, TappingsCollection})
