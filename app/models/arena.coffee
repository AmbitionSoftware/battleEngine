Model = require 'models/base/model'

module.exports = class ArenaModel extends Model
	defaults:
		id: 1
		name: 'ArenaName'
		damages:
			period: 2000
			deals: 15
			type: 'poison'
			duration: 100000
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
				
