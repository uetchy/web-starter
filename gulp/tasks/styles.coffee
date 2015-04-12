gulp = require 'gulp'

sass = require 'gulp-sass'
concat = require 'gulp-concat'
prefix = require 'gulp-autoprefixer'
minify = require 'gulp-minify-css'
sourcemaps = require 'gulp-sourcemaps'
gulpif = require 'gulp-if'
decomposer = require 'decomposer'
argv = require('yargs').argv

debug = !argv.production

gulp.task 'styles', ->
  gulp.src 'src/styles/**/*.sass'
    .pipe gulpif debug, sourcemaps.init()
    .pipe decomposer()
    .pipe sass
      indentedSyntax: true # .sass
      includePaths: ['bower_components']
    .on 'error', (err) ->
      console.error 'Error', err.message
    .pipe concat 'index.css'
    .pipe prefix browsers: ['last 2 versions']
    .pipe gulpif !debug, minify()
    .pipe gulpif debug, sourcemaps.write('.')
    .pipe gulp.dest 'dist/css'
