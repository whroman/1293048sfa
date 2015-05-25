require 'coffee-script/register'
fs = require 'fs'
path = require 'path'

getFileBuffer = (relPath) ->
    fs.readFileSync path.join __dirname, relPath

getJSON = (relPath) ->
    JSON.parse getFileBuffer relPath

gulp = require 'gulp'
gp = do require 'gulp-load-plugins'

paths = {}
options = {}

paths.build = './client/build'

paths.coffee = {}
paths.coffee.src = './client/coffee/**/*.coffee'

paths.scss = {}
paths.scss.src = './client/scss/index.scss'
paths.scss.watch = './client/scss/**/*.scss'

paths.jade = {};
paths.jade.src = './templates/index.jade'
paths.jade.watch = './templates/**/*.jade'

options.scss = {}
options.scss.outputStyle = 'compressed'

options.coffee = {}
options.coffee.base = true

options.uglify = {}
options.uglify.mangle = false

gulp.task 'scss:compile', ->
    gulp.src paths.scss.src
        .pipe gp.sourcemaps.init()
            .pipe gp.sass(options.scss).on 'error', gp.sass.logError
        .pipe gp.sourcemaps.write('./maps')
        .pipe gulp.dest paths.build

gulp.task 'coffee:compile', ->
    gulp.src paths.coffee.src
        .pipe gp.sourcemaps.init()
            .pipe(gp.coffee(options.coffee)
                .on 'error', (error) ->
                    console.log error
            )
            .pipe gp.uglify options.uglify
            .pipe gp.concat 'app.js'
        .pipe gp.sourcemaps.write('./maps')
        .pipe gulp.dest paths.build

gulp.task 'jade:compile', ->
    options = {}
    options.data = getJSON './samples/task_listview.json'
    gulp.src paths.jade.src
        .pipe gp.jade options
        .pipe gulp.dest './'

gulp.task 'client:compile', [
    'coffee:compile'
    'scss:compile'
    'jade:compile'
]

gulp.task 'watch', ->
    gulp.watch paths.coffee.src, ->
        gulp.run ['coffee:compile']

    gulp.watch paths.scss.watch, ->
        gulp.run ['scss:compile']

    gulp.watch paths.jade.watch, ->
        gulp.run ['jade:compile']

gulp.task 'default', [
    'client:compile',
    'watch'
]