gulp = require 'gulp'
jade = require 'gulp-jade'

gulp.task 'markups', ->
  gulp.src 'src/markups/*.jade'
    .pipe jade()
    .pipe gulp.dest 'dist'
