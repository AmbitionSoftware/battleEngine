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
    @collection = new  CharactersCollection
    @collection.url = 'data/accountCharacters.json'
    @collection.fetch
      success: (collection) ->
        view.render()

  getTemplateData: ->
    fighters: @collection.models

  render: ->
    super
    @collection.models.forEach @generateView, @
    Chaplin.mediator.publish 'teamOneReady', 'teamOne'

  generateView: (characterModel) ->
    name = characterModel.attributes.name
    container = @find '.character-'+ name
    characterView = new CharacterView autoRender: true, container: container, model: characterModel
    @subview name + 'View', characterView