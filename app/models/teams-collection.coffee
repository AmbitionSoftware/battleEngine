Collection = require 'models/base/collection'
TeamModel = require 'models/team'

module.exports = class TeamsCollection extends Collection
	model: TeamModel

