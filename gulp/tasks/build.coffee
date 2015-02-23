gulp = require 'gulp'

gulp.task 'build', [
  'markups'
  'scripts'
  'styles'
  'copy'
]
