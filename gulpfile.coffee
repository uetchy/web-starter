gulp        = require 'gulp'
{argv}      = require 'yargs'
gulpif      = require 'gulp-if'
notify      = require 'gulp-notify'
concat      = require 'gulp-concat'
sourcemaps  = require 'gulp-sourcemaps'
plumber     = require 'gulp-plumber'
browserSync = require 'browser-sync'
del         = require 'del'

# Scripts
browserify  = require 'browserify'
watchify    = require 'watchify'
source      = require 'vinyl-source-stream'
buffer      = require 'vinyl-buffer'
uglify      = require 'gulp-uglify'

# Markups
jade        = require 'gulp-jade'

# Styles
sass        = require 'gulp-sass'
prefix      = require 'gulp-autoprefixer'
minify      = require 'gulp-minify-css'
decomposer  = require 'decomposer'

# Publish
awspublish  = require 'gulp-awspublish'
rename      = require 'gulp-rename'
fs          = require 'fs'

debug = !argv.production

gulp.task 'default', ['watch']
gulp.task 'build', [
  'clean'
  'markups'
  'scripts'
  'styles'
]

gulp.task 'clean', (cb) ->
  del([
    'public/**/*.map'
  ], cb)

gulp.task 'markups', ->
  gulp.src 'src/**/*.jade'
    .pipe plumber()
    .pipe jade()
    .on "error", notify.onError(title: "Markups")
    .pipe gulp.dest 'public'

gulp.task 'styles', ->
  gulp.src 'src/styles/**/*.sass'
    .pipe plumber()
    .pipe gulpif debug, sourcemaps.init()
    .pipe decomposer()
    .pipe sass
      indentedSyntax: true
    .on "error", notify.onError(title: 'Styles')
    .pipe concat 'index.css'
    .pipe prefix browsers: ['last 2 versions']
    .pipe minify()
    .pipe gulpif debug, sourcemaps.write('.')
    .pipe gulp.dest 'public/css'

handleErrors = ->
  args = Array.prototype.slice.call arguments
  notify.onError
    title: 'Compile Error'
    message: "<%= error.message %>"
  .apply @, args
  @emit 'end'

buildScript = (watch) ->
  option = {
    entries: ['./src/scripts/index.coffee']
    extensions: ['.coffee', '.js']
    debug: debug
  }
  bundler =
    if watch
      option.cache        = {}
      option.packageCache = {}
      watchify(browserify(option))
    else
      browserify(option)

  bundler.transform 'coffeeify'
  bundler.transform 'debowerify'
  bundler.transform 'browserify-shim'

  bundle = ->
    bundler
      .bundle()
      .on 'error', handleErrors
      .pipe source 'index.js'
      .pipe buffer()
      .pipe gulpif debug,  sourcemaps.init(loadMaps: true)
      .pipe gulpif !debug, uglify()
      .pipe gulpif debug,  sourcemaps.write('.')
      .pipe gulp.dest 'public/js'

  bundler.on 'update', -> bundle()

  bundle()

gulp.task 'scripts', ->
  buildScript false

gulp.task 'watchify', ->
  buildScript true

gulp.task 'watch', ['watchify'], ->
  # watch src/
  gulp.watch 'src/styles/**/*.sass', ['styles']
  gulp.watch 'src/*.jade', ['markups']

  # watch public/
  browserSync
    notify: false
    server:
      baseDir: 'public'

  gulp.watch ['**/*'], {cwd: 'public'}, browserSync.reload

gulp.task 'publish', ['build'], ->
  publisher = awspublish.create JSON.parse(fs.readFileSync('./aws.json'))

  headers =
    'Cache-Control': 'max-age=315360000, no-transform, public'

  gulp.src 'public/**/*'
    # .pipe rename (path) ->
    #   path.dirname = '/path/to/publish/' + path.dirname
    #   return
    .pipe publisher.publish(headers)
    .pipe publisher.cache()
    .pipe awspublish.reporter()
