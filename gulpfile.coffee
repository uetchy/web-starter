gulp   = require 'gulp'
coffee = require 'gulp-coffee'
slim   = require 'gulp-slim'
sass   = require 'gulp-ruby-sass'

gulp.task 'js', ->
  gulp.src 'src/js/*.coffee'
    .pipe coffee(bare: true)
    .pipe gulp.dest('dist/js')

gulp.task 'markup', ->
  gulp.src 'src/html/*.slim'
    .pipe slim(pretty: true)
    .pipe gulp.dest('dist/')

gulp.task 'css', ->
  sass('src/css', { style: 'expanded' })
    .pipe gulp.dest('dist/css')

gulp.task 'default', ['css', 'js', 'markup']
