View = require 'views/base/view'

module.exports = class Character extends View
  template: require './templates/character'


  initialize: ->
    super

    # Temp values
    @dot = {}
    @eot = {}
    @hot = {}

    # Natural life recovery
    @naturalLifeRecovery()

    # Event to subscribe
    #TODO: finish enervation functionality
    # @subscribeEvent 'enervation', @enervationMediator
    @subscribeEvent 'damage', @damageMediator


  getTemplateData: ->
    @model.attributes


  ##########################
  ### CHARACTER RECOVERY ###
  ##########################

  naturalLifeRecovery: ->

    # Set values
    ratio = @model.get('life').recovery.ratio
    period =  @model.get('life').recovery.period
    duration = @model.get('life').recovery.duration

    # launch natural rcovery
    @healOverTime 'natural', ratio, period, duration


  healOverTime: (type, ratio, period, duration) ->

    # Set context
    view = @

    # Launch enervation loop
    @hot[type] = setInterval(->
      view.heal ratio
    , period)

    # Break enervation loop if needed
    if duration
      setInterval -> 
        clearInterval view.hot[type]
        clearInterval view.dot[type] if view.model.get('life').current <= 0
      , duration

  heal: (ratio, resurect) ->
    
    status = @model.get 'status'

    if resurect or status isnt 'dead'
      obj = @model.get 'life'
      newValue = obj['max'] * ratio + obj['current']
      obj["current"] = if newValue > obj["max"] then obj["max"] else newValue
      @updateStatus()
      @render()


  #############################
  ### CHARACTER ENERVATIONS ###
  #############################

  enervationMediator: (enervations) ->
  
    # Set context
    view = @

    enervations.life.forEach (enervation) ->
      view.enervationOverTime 'life', enervation.property, enervation.value, enervation.period, enervation.duration
    


  enervationOverTime: (enervationtType, property, value, period, duration) ->

    # Set context
    view = @

    # Launch enervation loop
    @eot[property] = setInterval(->
      view.enervation(enervationtType, property, value)
    , period)

    # Break enervation loop if needed
    if duration
      setInterval -> 
        clearInterval view.eot[property]
      , duration


  enervation: (enervationtType, property, value) ->
    
    # Get node property
    obj = @model.get enervationtType
    # Calculate new value
    obj[property] = obj[property] * value
    console.log obj



  #########################
  ### CHARACTER DAMAGES ###
  #########################

  damageMediator: (damages, type, period, duration, characterCid) ->

    # Set values
    currentCharacter = characterCid is @model.cid or characterCid is undefined
    damageOverTime = period isnt undefined

    # redirect to to correct method
    @damageOverTime damages, type, period, duration if damageOverTime and currentCharacter
    @damages damages, type if not damageOverTime and currentCharacter


  damageOverTime: (damages, type, period, duration) ->

    # Initialize
    view = @

    # Launch damage loop
    @dot[type] = setInterval(->
      view.damages(damages, type)
      clearInterval view.dot[type] if view.model.get('life').current <= 0
    , period)

    # Break damage loop if needed
    if duration
      setInterval -> 
        clearInterval view.dot[type]
      , duration


  damages: (damages, type) ->
    
    # Get node property
    obj = @model.get 'life'
    # Calculate new value
    newValue = obj.current - damages * @model.attributes.resilience[type]
    # Minimum value can't be less than 0
    if newValue <= 0 then newValue = 0 else newValue = Math.round newValue
    # Set character model with new value
    obj.current = newValue

    # Update character status
    @updateStatus()

    # Update view
    @render()



  ########################
  ### CHARACTER STATUS ###
  ########################

  updateStatus: ->

    # Get current character status and percent of life
    currentStatus = @model.get 'status' 
    perCentLife = 100 / @model.get('life').max * @model.get('life').current

    # Set new character status
    newStatus = switch
      when perCentLife > 49 then 'healthy'
      when 49 >= perCentLife > 29 then 'injured'
      when 29 >= perCentLife > 0 then 'critical'
      when perCentLife is 0 then 'dead'

    # Set new status
    @model.set status: newStatus if newStatus isnt currentStatus

    # Send event character model has changed
    Chaplin.mediator.publish 'characterUpdate', @model.get 'id'

