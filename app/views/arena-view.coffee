View = require 'views/base/view'

module.exports = class ArenaView extends View
	autoRender: true
	className: 'characterTwo'
	region: 'battleGround'

	initialize: ->
		super
		damagesParams = 
			characterModel: @collection.get 'c3'
			property: 'life'
			damages: 5
			resilienceProperty: 'poison'
		@damageOverTime(damagesParams, 3000, @damages, 20000)

	damageOverTime: (params, period, process, time) ->

		dot = setInterval(->
			process(params.characterModel, params.property, params.damages, params.resilienceProperty)
			if params.characterModel.get('life').current === 0
				clearInterval dot
		, period)

		if time
			setInterval ->
				clearInterval dot
			, time

	damages: (characterModel, property, damages, resilienceProperty) ->
		obj = characterModel.get property
		newValue = characterModel.get(property).current - damages * characterModel.get('resilience')[resilienceProperty]
		obj.current = newValue < 0 Math.round newValue : 0
		characterModel.set obj

	characterStatus: (characterModel) ->
		if lifePoints

