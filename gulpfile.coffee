# require('coffee-script/register')
gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
del = require 'del'

paths = 
	scripts: ['public/coffee/*.coffee']

gulp.task 'clean', (cb) ->
	del ['public/js/'], cb

gulp.task 'scripts', ['clean'], () ->
	gulp.src(paths.scripts)
	.pipe(sourcemaps.init())
	  .pipe(coffee())
	  .pipe(uglify())
	  .pipe(concat 'all.min.js')
	.pipe(sourcemaps.write())
	.pipe(gulp.dest 'public/js')

gulp.task 'watch', () ->
	gulp.watch paths.scripts, ['scripts']

gulp.task 'default', ['watch', 'scripts']