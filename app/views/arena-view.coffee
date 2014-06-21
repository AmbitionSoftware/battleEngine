View = require 'views/base/view'

module.exports = class ArenaView extends View
	autoRender: true
	className: 'characterTwo'
	region: 'battleGround'

	initialize: ->
		super
		characterModel = 'c3'
		damages = 10
		damagesType = 'poison'
		period = 3000
		maxTimer = 10000

		Chaplin.mediator.publish 'damage', characterModel, damages, damagesType, period, maxTimer

