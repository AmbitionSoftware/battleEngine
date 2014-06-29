View = require 'views/base/view'
LifeBarView = require 'views/life-bar-view'
ActionMenuView = require 'views/action-menu-view'
CharactersCollection = require 'models/characters-collection'


module.exports = class ActionsBarView extends View
  autoRender: false
  className: 'actionsBar'
  region: 'actionsBar'
  template: require './templates/actions-bar'

  initialize: ->
    super
    # Set context
    view = @
    # Subscribe character update event
    @subscribeEvent 'playerTeamCollection', @dataMediator


  dataMediator: (collection) ->
    @collection = collection
    @render()

  render: ->
    super
    # Generate each character view
    @collection.models.forEach @generateView, @

  generateView: (characterModel) ->
    # Containers
    lifeBarContainer = @find '.character-'+ characterModel.attributes.name + ' .life'
    actionMenuContainer = @find '.character-'+ characterModel.attributes.name + ' .actionButton'
    # generate view
    lifeBarView = new LifeBarView autoRender: true, container: lifeBarContainer, model: characterModel
    actionMenuView = new ActionMenuView autoRender: true, container: actionMenuContainer, model: characterModel
    # Add to subview
    @subview characterModel.attributes.name + 'LifeBarView', lifeBarView 
    @subview characterModel.attributes.name + 'ActionMenuView', actionMenuView 


  getTemplateData: ->
    fighters: @collection.models
