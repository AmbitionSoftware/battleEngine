Controller = require 'controllers/base/controller'
Arena = require 'views/arena-view'
TeamOne = require 'views/team-one-view'
TeamTwo = require 'views/team-two-view'
CharactersCollection = require 'models/characters-collection'

module.exports = class HomeController extends Controller

  index: ->
  	# Generate collection of team one
    teamOne = @teamOne = new  CharactersCollection
    @teamOne.add name: 'Pandinou'
    @teamOne.add name: 'TeemoPanda'
    @teamOne.add name: 'SuperMan'
    @teamOne.add name: 'Batman'

    # Generate collection of team two
    teamTwo = @teamTwo = new  CharactersCollection
    @teamTwo.add name: 'Lapinou'
    @teamTwo.add name: 'Chouqui'
    @teamTwo.add name: 'IronMan'
    @teamTwo.add name: 'Captain'

    # Generate collection of arena
    arenaCollection = @arenaCollection = new  CharactersCollection
    @arenaCollection.add teamOne.models
    @arenaCollection.add teamTwo.models

    # launch team view render
    @reuse 'teamsView', ->
      new TeamOne collection: teamOne
      new TeamTwo collection: teamTwo 

    # launch arena view render
    @reuse 'arenaView', ->
    	new Arena collection: arenaCollection

