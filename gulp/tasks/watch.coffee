gulp        = require 'gulp'
watch       = require 'gulp-watch'
browserSync = require 'browser-sync'
reload      = browserSync.reload

gulp.task 'watch', ['build'], ->
  # watch src/
  watch 'src/scripts/**/*', -> gulp.start 'scripts'
  watch 'src/styles/**/*',  -> gulp.start 'styles'
  watch 'src/markups/**/*', -> gulp.start 'markups'

  # watch dist/
  browserSync
    server:
      baseDir: 'dist'

  gulp.watch ['*.html', 'css/**/*.css', 'js/**/*.js'], {cwd: 'dist'}, reload
