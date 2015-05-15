window.jQuery = window.$ = require 'jquery'
Velocity = require 'velocity-animate'
domready = require 'domready'

MyModule = require './MyModule'

domready ->
  body = document.querySelector 'body'
