View = require 'views/base/view'

module.exports = class ArenaView extends View
	autoRender: true
	className: 'characterTwo'
	region: 'battleGround'

	initialize: ->
		super
		damagesParams = 
			characterAttributes: @collection.models[2].attributes
			property: 'life'
			damages: 5
			resilienceProperty: 'poison'
		@damageOverTime(damagesParams, 3000, @damages)

	damages: (characterAttributes, property, damages, resilienceProperty) ->
		characterAttributes[property].current = characterAttributes[property].current - damages * characterAttributes.resilience[resilienceProperty]

	damageOverTime: (params, period, process) ->
		setInterval(->
			console.log 'tick'
			process(params.characterAttributes, params.property, params.damages, params.resilienceProperty)
		, period)