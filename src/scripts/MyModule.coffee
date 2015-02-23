class MyModule
  constructor: (name) ->
    @name = name

  say: ->
    console.log "Hello, #{@name}"

module.exports = MyModule
