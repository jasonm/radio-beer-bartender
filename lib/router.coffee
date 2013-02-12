exports.Router =
  class Router extends Backbone.Router
    initialize: (rootEl) =>
      @rootEl = rootEl
      @tabsEl = $('ul.nav') # TODO: inject

    routes:
      '': 'home'
      'home': 'showHash'
      'taps': 'showHash'
      'beers': 'showHash'
      'readers': 'showHash'
      'scans': 'showHash'

    showTab: (tab) =>
      @rootEl.find('>div').hide()
      @rootEl.find("#region-#{tab}").show()

      @tabsEl.find('li').removeClass('active')
      @tabsEl.find("li a[href=##{tab}]").closest('li').addClass('active')

    home: =>
      @showTab 'home'

    showHash: =>
      @showTab document.location.hash.replace('#', '')
