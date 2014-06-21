View = require 'views/base/view'

module.exports = class Character extends View
	template: require './templates/character'
	# listen:
	# 	'change model' : 'render'

	initialize: ->
		super
		@subscribeEvent 'damage', @damageMediator


	getTemplateData: ->
		@model.attributes


	damageMediator: (characterCid, damages, type, period, maxTimer) ->

		# Set values
		currentCharacter = characterCid is @model.cid or characterCid is undefined
		damageOverTime = period isnt undefined

		# redirect to to correct method
		@damageOverTime damages, type, period, maxTimer if damageOverTime and currentCharacter
		@damages damages, type if not damageOverTime and currentCharacter


	damageOverTime: (damages, type, period, maxTimer) ->

		# Set view context
		view = @

		# Launch damage loop
		dot = setInterval(->
			view.damages(damages, type)
			clearInterval dot if view.model.get('life').current <= 0
		, period)

		# Break damage loop if needed
		if maxTimer
			setInterval -> 
				clearInterval dot
			, maxTimer 


	damages: (damages, type) ->

		# Get node property
		obj = @model.get 'life'
		# Set new value
		newValue = @model.get('life').current - damages * @model.get('resilience')[type]
		# Minimum value can't be less than 0
		if newValue <= 0 then obj.current = 0 else obj.current = Math.round newValue
		# Set character model with new value
		@model.set obj

		# Update character status
		@characterStatus()

		# Update view
		@render()

	characterStatus: ->

		# Get current character status and percent of life
		currentStatus = @model.get 'status' 
		perCentLife = 100 / @model.get('life').max * @model.get('life').current

		# Set new character status
		newStatus = switch
			when perCentLife > 49 then 'healthy'
			when 49 >= perCentLife > 29 then 'injured'
			when 29 >= perCentLife > 0 then 'critical'
			when perCentLife is 0 then 'dead'

		# Set new status
		@model.set status: newStatus if newStatus isnt currentStatus

