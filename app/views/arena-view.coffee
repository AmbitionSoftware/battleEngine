View = require 'views/base/view'

module.exports = class ArenaView extends View
  autoRender: true
  className: 'characterTwo'
  region: 'battleGround'

  initialize: ->
    super

    # Temp values
    @teamReady =
      teamOne: false
      teamTwo: false

    # Event to subscribe
    @subscribeEvent 'teamOneReady', @mediator
    @subscribeEvent 'teamTwoReady', @mediator


  mediator: (team) ->

    # Set the view loaded 
    @teamReady[team] = true

    # Launch 
    @enervation() if @model.get('enervation') isnt {} and @teamReady.teamOne and @teamReady.teamTwo
    @damages() if @model.get('damages') isnt {} and @teamReady.teamOne and @teamReady.teamTwo


  enervation: ->

    # Set values
    enervation = @model.get('enervations')

    # Apply enervation
    Chaplin.mediator.publish 'enervation', enervation


  damages: ->

    # Set values
    deals = @model.get('damages').deals
    type = @model.get('damages').type
    period = @model.get('damages').period
    duration = @model.get('damages').duration

    # Apply damages
    Chaplin.mediator.publish 'damage', deals, type, period, duration


