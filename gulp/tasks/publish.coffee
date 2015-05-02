gulp       = require 'gulp'
awspublish = require 'gulp-awspublish'
rename     = require 'gulp-rename'
fs         = require 'fs'

gulp.task 'publish', ['build'], ->
  publisher = awspublish.create JSON.parse(fs.readFileSync('./aws.json'))

  headers =
    'Cache-Control': 'max-age=315360000, no-transform, public'

  gulp.src 'dist/**/*'
    .pipe rename (path) ->
      path.dirname = '/hifuu/' + path.dirname
      return
    .pipe publisher.publish(headers)
    .pipe publisher.cache()
    .pipe awspublish.reporter()
