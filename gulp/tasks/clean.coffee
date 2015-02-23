gulp = require 'gulp'

del = require 'del'

gulp.task 'clean', del.bind(null, ['dist', 'tmp', '**/*.log'])
