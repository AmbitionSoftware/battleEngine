View = require 'views/base/view'

module.exports = class Character extends View
	template: require './templates/character'
	listen:
		'change model' : 'render'

	getTemplateData: ->
		@model.attributes
