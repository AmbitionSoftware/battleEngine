View = require 'views/base/view'
CharacterView = require 'views/character-view'
CharactersCollection = require 'models/characters-collection'

module.exports = class TeamTwoView extends View
  autoRender: true
  className: 'teamTwo'
  region: 'secondPlayer'
  template: require './templates/teams'
  events:
    'click .fighters li': 'setActiveCharacter',

  initialize: ->
    super
    view = @
    @activeCharacterId = false
    @collection = new  CharactersCollection
    @collection.url = 'data/enemyCharacters.json'
    @collection.fetch
      success: (collection) ->
        view.render()

  getTemplateData: ->
    fighters: @collection.models

  render: ->
    super
    @collection.models.forEach @generateView, @
    Chaplin.mediator.publish 'teamTwoReady', 'teamTwo'

  generateView: (characterModel) ->
    id = characterModel.attributes.id
    container = @find '.character-'+ id
    characterView = new CharacterView autoRender: true, container: container, model: characterModel
    @subview 'character-'+ id + 'View', characterView

  setActiveCharacter: (event, all) ->
    # Remove all active classes on table
    @findAll('.fighters li').forEach (elem) ->
      elem.classList.remove "active"
    # Set selected character id
    domId = event.delegateTarget.getAttribute 'class'
    @activeCharacterId = domId.substr domId.indexOf '-' -1
    # Add active classes on character
    event.delegateTarget.classList.add "active"
    # Inform which enemy is selected
    Chaplin.mediator.publish 'enemyActiveCharacterID', @activeCharacterId