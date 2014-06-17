View = require 'views/base/view'
Character = require 'views/character-view'

module.exports = class CharacterTwoView extends View
	autoRender: true
	className: 'characterTwo'
	region: 'secondPlayer'
	template: require './templates/teams'

	getTemplateData: ->
		fighters: @collection.models

	render: ->
		super
		@collection.models.forEach @generateView, @

	generateView: (characterModel) ->
		name = characterModel.attributes.name
		container = @find('.character-'+ name)
		characterView = new Character autoRender: true, container: container, model: characterModel
		@subview name + 'View', characterView