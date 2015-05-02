gulp        = require 'gulp'
{argv}      = require 'yargs'
del         = require 'del'
gulpif      = require 'gulp-if'
notify      = require 'gulp-notify'
watch       = require 'gulp-watch'
concat      = require 'gulp-concat'
sourcemaps  = require 'gulp-sourcemaps'
browserSync = require 'browser-sync'
reload      = browserSync.reload

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

debug = !argv.production

gulp.task 'default', ['build']
gulp.task 'build', [
  'markups'
  'scripts'
  'styles'
]

gulp.task 'clean',
  del.bind(null, ['public', 'tmp', '**/*.log'])

gulp.task 'copy', ->
  gulp.src ['src/assets/*'], base: 'src'
    .pipe gulp.dest 'public'

gulp.task 'markups', ->
  gulp.src 'src/**/*.jade'
    .pipe jade()
    .pipe gulp.dest 'public'

gulp.task 'styles', ->
  gulp.src 'src/styles/**/*.sass'
    .pipe gulpif debug, sourcemaps.init()
    .pipe decomposer()
    .pipe sass
      indentedSyntax: true
    .on 'error', (err) ->
      console.error 'Error', err.message
    .pipe concat 'index.css'
    .pipe prefix browsers: ['last 2 versions']
    .pipe gulpif !debug, minify()
    .pipe gulpif debug, sourcemaps.write('.')
    .pipe gulp.dest 'public/css'

handleErrors = ->
  args = Array.prototype.slice.call arguments
  notify.onError
      title:   "Compile Error"
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

  bundle = ->
    bundler
      .bundle()
      .on 'error', handleErrors
      .pipe source 'bundle.js'
      .pipe buffer()
      .pipe gulpif debug,  sourcemaps.init(loadMaps: true)
      .pipe gulpif !debug, uglify()
      .pipe gulpif debug,  sourcemaps.write('.')
      .pipe gulp.dest 'public/js'

  bundler.on 'update', -> bundle()
  bundler.on 'time', (time) ->
    console.log time

  bundle()

gulp.task 'scripts', ->
  buildScript false

gulp.task 'watchify', ->
  buildScript true

gulp.task 'watch', ['watchify'], ->
  # watch src/
  watch 'src/styles/**/*.sass', -> gulp.start 'styles'
  watch 'src/**/*.jade',        -> gulp.start 'markups'

  # watch public/
  browserSync
    server:
      baseDir: 'public'
  gulp.watch ['**/*.html', '**/*.css', '**/*.js'], {cwd: 'public'}, reload
