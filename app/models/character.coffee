Model = require 'models/base/model'

module.exports = class CharacterModel extends Model
	defaults:
		name: 'alpha'
		status: 'healthy'
		level: 1
		life: 
			current: 100
			min: 0
			max: 100
			regenCoef: 1
		experience:
			current: 70
			nextLevel: 100
			coef: 1
		resilience:
			poison: 1
			fire: 1
			water: 1
			fire: 1
			earth: 1
			thunder: 1
			dark: 1
			armor: 30
		power:
			attack: 20

