MyModule = require './MyModule'

do (document) ->
  'use strict'

  init = ->
    body = document.querySelector 'body'
    # do something

  document.addEventListener 'DOMContentLoaded', ->
    init()
