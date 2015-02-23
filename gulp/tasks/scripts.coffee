gulp = require 'gulp'

browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
gulpif = require 'gulp-if'
argv = require('yargs').argv

debug = !argv.production

gulp.task 'scripts', ->
  browserify
    entries: ['./src/scripts/index.coffee']
    extensions: ['.coffee', '.js']
    debug: debug
  .transform 'coffeeify'  # coffee
  .transform 'debowerify' # bower
  .bundle()
  .on 'error', (err) ->
    console.log err.message
    this.emit 'end'
  .pipe source 'bundle.js'
  .pipe buffer()
  .pipe gulpif debug, sourcemaps.init(loadMaps: true)
  .pipe gulpif !debug, uglify() # uglify
  .pipe gulpif debug, sourcemaps.write()
  .pipe gulp.dest 'dist/js'
