exports.StatefulItemView =
  class StatefulItemView extends Backbone.Marionette.ItemView
    state:
      'Stateful Views must define a default state'

    statefulViewEvents:
      'click a.state-control': 'clickState'

    delegateEvents: (events) =>
      baseEvents = events || @events
      mergedEvents = _.extend(baseEvents, StatefulItemView.prototype.statefulViewEvents)
      super(mergedEvents)

    clickState: (e) =>
      @setState($(e.target).data('state'))
      e.preventDefault()

    setState: (state) =>
      @state = state
      @render()
      @trigger('change:state', state)
