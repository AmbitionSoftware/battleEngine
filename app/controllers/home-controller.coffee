Controller = require 'controllers/base/controller'
Arena = require 'views/arena-view'
CharacterOne = require 'views/character-one-view'
CharacterTwo = require 'views/character-two-view'
CharactersCollection = require 'models/characters-collection'

module.exports = class HomeController extends Controller

  index: ->
    charactersOneCollection = @charactersOneCollection = new  CharactersCollection
    @charactersOneCollection.add name: 'Pandinou'
    @charactersOneCollection.add name: 'TeemoPanda'
    @charactersOneCollection.add name: 'SuperMan'
    @charactersOneCollection.add name: 'Batman'

    charactersTwoCollection = @charactersTwoCollection = new  CharactersCollection
    @charactersTwoCollection.add name: 'Lapinou'
    @charactersTwoCollection.add name: 'Chouqui'
    @charactersTwoCollection.add name: 'IronMan'
    @charactersTwoCollection.add name: 'Captain'

    arenaCollection = @arenaCollection = new  CharactersCollection
    @arenaCollection.add charactersOneCollection.models
    @arenaCollection.add charactersTwoCollection.models

    @reuse 'charactersView', ->
      new CharacterOne collection: charactersOneCollection
      new CharacterTwo collection: charactersTwoCollection 

    @reuse 'arenaView', ->
    	new Arena collection: arenaCollection