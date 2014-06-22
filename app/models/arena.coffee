Model = require 'models/base/model'

module.exports = class ArenaModel extends Model
	defaults:
		id: 1
		name: 'ArenaName'
		damages:
			period: 3000
			deals: 10
			type: 'poison'
			duration: 3000
			iterationPeriod: false
		enervations:
			life: [
				{
					property: 'recovery'
					value: 1
					period: 0
					duration: false
				}
			]
			resilience: [
				poison: 0.7
			]
				
