View = require 'views/base/view'

module.exports = class Character extends View
	template: require './templates/character'
	listen:
		'onchange:attributes model' : 'justLog'

	initialize: ->
		super
		# that = @render
		# setInterval(->
		# 	console.log('update')
		# 	that()
		# , 1000)

	getTemplateData: ->
		@model.attributes

	justLog: ->
		console.log('render')
