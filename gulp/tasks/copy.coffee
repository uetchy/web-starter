gulp = require 'gulp'

gulp.task 'copy', ->
  gulp.src ['src/assets/*'], base: 'src'
    .pipe gulp.dest 'dist'
