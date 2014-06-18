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
			damages: 10
			resilienceProperty: 'poison'
		@damageOverTime(damagesParams, 3000)

	damageOverTime: (params, period, time) ->
		view = @
		dot = setInterval(->
			view.damages(params.characterModel, params.property, params.damages, params.resilienceProperty)
			clearInterval dot if params.characterModel.get('life').current <= 0
		, period)

		if time
			setInterval -> 
				clearInterval dot
			, time 


	damages: (characterModel, property, damages, resilienceProperty) ->

		# Set damage to the character
		obj = characterModel.get property
		newValue = characterModel.get(property).current - damages * characterModel.get('resilience')[resilienceProperty]
		if newValue <= 0 then obj.current = 0 else obj.current = Math.round newValue
		characterModel.set obj

		# Set character status
		@characterStatus characterModel


	characterStatus: (characterModel) ->

		# Get current character status and percent of life
		currentStatus = characterModel.get 'status' 
		perCentLife = 100 / characterModel.get('life').max * characterModel.get('life').current

		# Set new character status
		characterModel.set status: 'healthy' if perCentLife > 59 and currentStatus isnt 'healthy'
		characterModel.set status: 'injured' if 59 >= perCentLife > 29 and currentStatus isnt 'injured'
		characterModel.set status: 'critical' if 29 >= perCentLife > 0 and currentStatus isnt 'critical'
		characterModel.set status: 'dead' if perCentLife is 0 and currentStatus isnt 'dead'

