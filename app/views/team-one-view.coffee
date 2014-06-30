View = require 'views/base/view'
CharacterView = require 'views/character-view'
CharactersCollection = require 'models/characters-collection'


module.exports = class TeamOneView extends View
  autoRender: false
  className: 'teamOne'
  region: 'firstPlayer'
  template: require './templates/teams'

  initialize: ->
    super
    view = @
    @subscribeEvent 'playerActiveCharacterID', @setActiveCharacter
    @collection = new  CharactersCollection
    @collection.url = 'data/accountCharacters.json'
    @collection.fetch
      success: (collection) ->
        view.render()


  getTemplateData: ->
    fighters: @collection.models


  render: ->
    super
    # Generate each character view
    @collection.models.forEach @generateView, @
    # Send team ready status
    Chaplin.mediator.publish 'teamOneReady', 'teamOne'
    # Send collection to action view
    Chaplin.mediator.publish 'playerTeamCollection', @collection


  generateView: (characterModel) ->
    id = characterModel.attributes.id
    container = @find '.character-'+ id
    characterView = new CharacterView autoRender: true, container: container, model: characterModel
    @subview 'character-'+ id + 'View', characterView


  setActiveCharacter: (id) ->
    # Remove all active classes on table
    @findAll('.fighters li').forEach (elem) ->
      elem.classList.remove "active"
    # Add active classes on table
    @find(".character-" + id).classList.add "active"