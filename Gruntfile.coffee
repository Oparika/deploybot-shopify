module.exports = (grunt) ->

  # Global vars
  gulp = require 'gulp'
  cssimport = require 'gulp-cssimport'
  paths =
    css: 'src/stylesheets/**/*.*'
    concatFiles: [
      'src/stylesheets/*.*'
    ]
    images: 'assets/*.{png,jpg,gif}'
    assets: 'assets/'
    allAssets: [
      'assets/*.*',
      'config/*',
      'layout/*',
      'locales/*',
      'snippets/*',
      'templates/**/*'
    ]

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    # Helper methods
    notify:
      zip:
        options:
          message: 'Zip file created'

    # Shopify theme_gem methods
    exec:
      theme_watch:
        command: 'bundle exec theme watch'
      deploy:
        command: 'bundle exec theme upload'

    # File manipulation
    gulp:
      concat: ->
        return gulp.src(paths.concatFiles)
          .pipe(cssimport())
          .pipe(gulp.dest(paths.assets))

    imagemin:
      dynamic:
        options:
          optimizationLevel: 3
        files: [{
          expand: true
          src: paths.images
        }]

    # Action methods
    watch:
      styles:
        files: paths.css
        tasks: ['gulp']
      images:
        files: [paths.images]
        tasks: ['imagemin']

    concurrent:
      options:
        logConcurrentOutput: true
      watch:
        tasks: ['watch', 'exec']

    clean:
      plugins: [
        '*.zip',
        'assets/**/*',
        '!assets/*.*'
      ]

    compress:
      main:
        options:
          mode: 'zip'
          archive: '<%= pkg.name %>.zip'
        files: [
          src: paths.allAssets
        ]

    open:
      build:
        path: 'https://themes.shopify.com/services/internal/themes/<%= pkg.name %>/edit'

  # Load NPM task plugins
  require('load-grunt-tasks')(grunt)

  # Register tasks
  grunt.registerTask 'default', ['concurrent:watch']
  grunt.registerTask 'build', ['gulp', 'imagemin', 'clean']
  grunt.registerTask 'deploy', ['gulp', 'imagemin', 'exec:deploy']
  grunt.registerTask 'zip', ['gulp', 'imagemin', 'clean', 'compress', 'notify:zip', 'open:build']
