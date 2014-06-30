View = require 'views/base/view'
LifeBarView = require 'views/life-bar-view'
ActionMenuView = require 'views/action-menu-view'
CharactersCollection = require 'models/characters-collection'


module.exports = class ActionsBarView extends View
  autoRender: false
  className: 'actionsBar'
  region: 'actionsBar'
  template: require './templates/actions-bar'
  events:
    'click table .character': 'setActiveCharacter',


  initialize: ->
    super
    # Subscribe character update event
    @subscribeEvent 'playerTeamCollection', @dataMediator
    # Subscribe character update event
    @subscribeEvent 'enemyActiveCharacterID', @selectedEnemy


  selectedEnemy: (id) ->
    @activeEnemyId = id


  dataMediator: (collection) ->
    # Set collection
    @collection = collection
    # Take the first character id of the collection
    @activeCharacterId = @collection.at(0).get 'id'
    # Render the view
    @render()


  getTemplateData: ->
    fighters: @collection.models


  setActiveCharacter: (event) ->
    # Remove all active classes on table
    @findAll('.character').forEach (elem) ->
      elem.classList.remove "active"
    # Remove all active classes on pictures
    @findAll('.picture li').forEach (elem) ->
      elem.classList.remove "active"
    # Add active classes on table
    if event
      event.delegateTarget.classList.add "active"
      domId = event.delegateTarget.getAttribute 'id'
      @activeCharacterId = domId.substr domId.indexOf '-' -1
    else
      @find("#character-" + @activeCharacterId).classList.add "active"
    # Add active class on picture
    @find(".character-" + @activeCharacterId).classList.add "active"
    # Inform which character is selected
    Chaplin.mediator.publish 'playerActiveCharacterID', @activeCharacterId


  render: ->
    super
    # Generate each character view
    @collection.models.forEach @generateView, @
    @setActiveCharacter()


  generateView: (characterModel) ->
    # Containers
    lifeBarContainer = @find '#character-'+ characterModel.attributes.id + ' .life'
    actionMenuContainer = @find '#character-'+ characterModel.attributes.id + ' .actionButton'
    # generate view
    lifeBarView = new LifeBarView autoRender: true, container: lifeBarContainer, model: characterModel
    actionMenuView = new ActionMenuView autoRender: true, container: actionMenuContainer, model: characterModel
    # Add to subview
    @subview characterModel.attributes.id + 'LifeBarView', lifeBarView
    @subview characterModel.attributes.id + 'ActionMenuView', actionMenuView
