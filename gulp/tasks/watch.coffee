gulp      = require 'gulp'
webserver = require 'gulp-webserver'
watch     = require 'gulp-watch'

gulp.task 'watch', ['build'], ->
  # watch files
  watch 'src/scripts/**/*', -> gulp.start 'scripts'
  watch 'src/styles/**/*', -> gulp.start 'styles'
  watch 'src/markups/**/*', -> gulp.start 'markups'

  # start server and livereload assets
  gulp.src 'dist'
    .pipe webserver
      livereload: true
