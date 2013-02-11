$(function() {
  var handlebars = require('handlebars');
  var options = {};

  Backbone.Marionette.Renderer.render = function (template, data) {
    return handlebars.templates[template](data, options);
  }
});
