/**
 * Gulp build file
 *
 * To install Gulp, it requires NodeJS and NPM to be installed.
 *
 *  npm install --global gulp
 *
 * When using Gulp. go to th root folder of the project, run:
 *
 *  npm install --save-dev gulp
 *
 * A list of plugins needed:
 *
 *  - gulp-concat - to concat the files into one
 *  - gulp-uglify - to minify the file
 *  - gulp-ng-annotate - Add angularjs dependency injection annotations with ng-annotate (https://www.npmjs.com/package/gulp-ng-annotate)
 *  - gulp-sourcemaps - Source map support for Gulp.js (https://www.npmjs.com/package/gulp-sourcemaps)
 *
 * For "clean" task, it also needs a Node plugin - "del"
 *
 */

//
//--- Gulp & Plugins
//--------------
//==============
var gulp = require('gulp')
var concat = require('gulp-concat')
var sourcemaps = require('gulp-sourcemaps')
var uglify = require('gulp-uglify')
var ngAnnotate = require('gulp-ng-annotate')
// Directly use NPM package "del" to clean up the files.
// https://github.com/gulpjs/gulp/blob/master/docs/recipes/delete-files-folder.md
var del = require('del');

//
//--- Variables
//--------------
//==============
var dist = "./dist";
// The list of files / folders that need to be moved into "dist".
var filesToMove = [
    './.gitignore',
    './.Rbuildignore',
    './.RData',
    './.Rhistory',
    './DESCRIPTION',
    './NAMESPACE',
    './phph.Rproj',
    './data/**/*',
    './data-raw/**/*',
    './man/**/*',
    './R/**/*'
];
var webappDist = dist + '/inst/www';

//
//--- Tasks
//--------------
//==============

gulp.task('base-clean', function(clean){
    del([
        dist
    ], clean)
});

// Move all files (except the web app) into the "dist" folder.
gulp.task('base-copy', ['base-clean'], function() {
    gulp.src(filesToMove, {
        base: './'
    })
        .pipe(gulp.dest(dist))
})

// Move all other static files (except js and css files) into the "dist" folder.
gulp.task('static-copy', ['base-clean'], function() {
    gulp.src([
        'inst/www/**/*',
        '!inst/www/app/**/*.js',
        '!inst/www/app/**/*.css'
    ], {
        base: './'
    })
        .pipe(gulp.dest(dist))
})

// Process "Lib-related JS' files
gulp.task('lib-js', ['base-clean'], function () {
    gulp.src([
        // OpenCPU related
        'inst/www/asset/lib/opencpu/**/*.js',
        // Bootstrap related
        'inst/www/asset/lib/bootstrap/**/*.js',
        // Angular relaterd
        'inst/www/asset/lib/angular/**/*.js'
    ])
        .pipe(sourcemaps.init())
            .pipe(concat('asset/js/app-lib.js'))
            //.pipe(ngAnnotate())
            //.pipe(uglify())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(webappDist))
})


// Process "App-related JS' files
gulp.task('app-js', ['base-clean'], function () {
    gulp.src([
        'inst/www/app/**/*.module.js',
        'inst/www/app/app.route.js',
        'inst/www/app/app.data.js',
        'inst/www/app/**/*.js'
    ])
        .pipe(sourcemaps.init())
            .pipe(concat('asset/js/app.js'))
            .pipe(ngAnnotate())
            .pipe(uglify())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(webappDist))
})

// Process "Lib-related CSS' files
gulp.task('lib-css', ['base-clean'], function () {
    gulp.src([
        'inst/www/asset/lib/**/*.css',
    ])
        .pipe(sourcemaps.init())
        .pipe(concat('asset/css/app-lib.css'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(webappDist))
})

// Process "App-related CSS' files
gulp.task('app-css', ['base-clean'], function () {
    gulp.src([
        'inst/www/asset/css/**/*.css',
    ])
        .pipe(sourcemaps.init())
            .pipe(concat('asset/css/app.css'))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(webappDist))
})


gulp.task('default', [
    'base-clean',
    'base-copy',
    'static-copy',
    //'lib-js',
    'app-js',
    //'lib-css',
    'app-css'
]);