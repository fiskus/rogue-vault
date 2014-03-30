module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        coffee: {
            compile: {
                options: {
                    bare: true,
                    sourceMap: true
                },
                files: {
                    '_build/js/base.js': [
                        'coffee/libs-wrapper.coffee',
                        'coffee/*.coffee',
                        'coffee/*/*.coffee',
                    ],
                }
            }
        },
        handlebars: {
            compile: {
                options: {
                    namespace: 'JST'
                },
                files: {
                    '_build/jst/base.js': [
                        'handlebars/*.hbs'
                    ],
                }
            }
        },
        jade: {
            base: {
                options: {
                    data: function() {
                        return require('./api-mock/test.json')
                    }
                },
                files: {
                    'index.html': 'jade/base.jade'
                }
            },
            person: {
                options: {
                    data: function() {
                        return require('./api-mock/test.json')
                    }
                },
                files: {
                    'person.html': 'jade/person.jade'
                }
            }
        },
        stylus: {
            compile: {
                files: {
                    '_build/css/base.css': 'stylus/base.styl',
                }
            }
        },
        uglify: {
            libs: {
                files: {
                    '_build/js_min/libs.js': [
                        'lib/gator.js',
                        'lib/handlebars.js',
                        'lib/lodash.js',
                        'lib/qwest.js',
                        'lib/xxspubsub.js',
                    ]
                }
            },
            scripts: {
                files: {
                    '_build/js_min/base.min.js': '_build/js/base.js',
                }
            },
            templates: {
                files: {
                    '_build/jst/base.js': '_build/jst/base.js',
                }
            }
        },
        watch: {
            css: {
                files: 'stylus/*.styl',
                tasks: 'stylus'
            },
            handlebars: {
                files: ['handlebars/*.hbs'],
                tasks: ['handlebars', 'uglify:templates']
            },
            jade: {
                files: ['jade/*.jade', 'api-mock/*.json'],
                tasks: 'jade'
            },
            libs: {
                files: ['libs/*.js'],
                tasks: ['uglify:libs']
            },
            coffee: {
                files: ['coffee/*.coffee', 'coffee/*/*.coffee'],
                tasks: ['coffee', 'uglify:scripts']
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-handlebars');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('default', ['coffee', 'handlebars', 'uglify', 'stylus', 'jade', 'watch']);
    grunt.registerTask('build-prod', ['coffee', 'handlebars', 'uglify', 'jade', 'stylus']);
};
