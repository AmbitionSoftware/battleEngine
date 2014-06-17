View = require 'views/base/view'

module.exports = class Character extends View
	template: require './templates/character'
	listen:
		'change:attributes model' : 'render'

	initialize: ->
		super
		# that = @render
		# setInterval(->
		# 	console.log('update')
		# 	that()
		# , 1000)

	getTemplateData: ->
		@model.attributes
