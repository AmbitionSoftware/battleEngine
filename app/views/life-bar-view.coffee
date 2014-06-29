View = require 'views/base/view'

module.exports = class LifeBar extends View
  template: require './templates/lifeBar'

  initialize: ->
    super
    @subscribeEvent 'characterUpdate', @render

  getTemplateData: ->
    @model.get 'life'