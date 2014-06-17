View = require 'views/base/view'

module.exports = class ArenaView extends View
	autoRender: true
	className: 'characterTwo'
	region: 'battleGround'

	initialize: ->
		super
		# damagesParams = 
		# 	characterModel: @collection.get 'c3'
		# 	property: 'life'
		# 	damages: 5
		# 	resilienceProperty: 'poison'
		# @damageOverTime(damagesParams, 3000, @damages)

	damages: (characterModel, property, damages, resilienceProperty) ->
		obj = characterModel.get property
		obj.current = characterModel.get(property).current - damages * characterModel.get('resilience')[resilienceProperty]
		characterModel.set obj

	damageOverTime: (params, period, process) ->
		setInterval(->
			process(params.characterModel, params.property, params.damages, params.resilienceProperty)
		, period)