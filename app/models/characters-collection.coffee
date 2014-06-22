Collection = require 'models/base/collection'
CharacterModel = require 'models/character'

module.exports = class CharactersCollection extends Collection
	model: CharacterModel