Application = require 'application'
routes = require 'routes'

# Initialize the application on DOM ready event.
document.addEventListener 'DOMContentLoaded', ->

  'use strict'

  new Application {
    title: 'battleEngine',
    controllerSuffix: '-controller',
    routes
  }
  
, false