Controller = require 'controllers/base/controller'
Arena = require 'views/arena-view'
TeamOne = require 'views/team-one-view'
TeamTwo = require 'views/team-two-view'
ActionsBar = require 'views/actions-bar-view'
CharactersCollection = require 'models/characters-collection'
ArenasCollection = require 'models/arenas-collection'
TeamsCollection = require 'models/teams-collection'

module.exports = class HomeController extends Controller

  index: ->

    # Get player team config
    playerTeam = new  TeamsCollection
    playerTeam.url = 'data/accountTeams.json'
    playerTeam.fetch()

    # Get enemy team config
    enemyTeam = new  TeamsCollection
    enemyTeam.url = 'data/enemyTeams.json'
    enemyTeam.fetch()

    # launch team view render
    @reuse 'teamsView', ->
      new ActionsBar
      new TeamOne model: playerTeam
      new TeamTwo model: enemyTeam


    # Generate collection of arena
    @arenaCollection = new  ArenasCollection
    @arenaCollection.add name: 'Black forest'
    arenaModel = @arenaCollection.get 1

    # launch arena view render
    @reuse 'arenaView', ->
      new Arena model: arenaModel

