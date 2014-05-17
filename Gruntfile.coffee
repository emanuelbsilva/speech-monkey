module.exports = (grunt) ->
	grunt.initConfig {

		coffee:
			dist:
				options:
					join: true
					sourceMap: true
					bare: true
				expand: true,
				flatten: true,
				cwd: 'src/coffee'
				src: ['**/*.coffee']
				dest: 'src/coffee-built'
				ext: '.js'
			test: 
				options:
					join: true
					sourceMap: false
					bare: true
				expand: true,
				flatten: true,
				cwd: 'test/coffee'
				src: ['*.coffee']
				dest: 'test/coffee-built'
				ext: '.js'


		less:
			dist:
				options:
					paths: ['src/less']
				files:
					'src/less-built/styles.css': 'src/less/styles.less'

		clean:
			build: 'build/'

		copy:
			build:
				dest: 'build/'
				src: [ 'img/**', 'plugin/**', 'font/**' ]
				expand: true
				cwd: 'src'

			html:
				dest: 'build/'
				src: 'index.html'
				expand: true
				cwd: 'src'

		htmlmin:
			build:
				files: { 'build/index.html': 'build/index.html' }
				options:
					removeComments: false

		useminPrepare:
			html: 'src/index.html'
			options:
				dest: 'build/'

		concat:
			'build/app.js':
				options:
					separator: ';'

		usemin:
			html: 'build/index.html'
			options:
				replaceAssets: false

		uglify:
			options:
				compress:
					global_defs:
						"DEBUG": false

		connect:
			dev:
				options:
					port: 9001
					base: '.'
					hostname: "*"
					keepalive: false
					middleware: (connect, options) -> [ require('connect-livereload')(), connect.static(options.base), connect.directory(options.base) ]

			build:
				options:
					port: 9002
					base: 'build'
					hostname: "*"
					keepalive: true

		open:
			root:
				path: 'http://127.0.0.1:9001'
			dev:
				path: 'http://127.0.0.1:9001/src'
			build:
				path: 'http://127.0.0.1:9002'
			throttle:
				path: 'http://127.0.0.1:9003'

		watch:
			coffeeDist:
				files: [ 'src/coffee/**/*.coffee' ]
				tasks: 'coffee:dist'
				options:
					nospawn: true
					livereload: true
					
			coffeeTest:
				files: [ 'test/coffee/**/*.coffee' ]
				tasks: 'coffee:test'
				options:
					nospawn: true
					livereload: true

			less:
				files: [ 'src/less/*.less' ]
				tasks: 'less'
				options:
					nospawn: true
					livereload: true

			other:
				files: [ 'src/js/*', 'src/css/*', 'src/img/*', 'src/*' ]
				options:
					nospawn: true
					livereload: true

	}

	grunt.registerTask('default', 'dev')
	grunt.registerTask('dev', [ 'preprocess', 'connect:dev', 'open:dev', 'watch' ])
	grunt.registerTask('build', [ 'preprocess', 'copy:build', 'usemin-all' ])

	grunt.registerTask('preprocess', [ 'coffee', 'less' ])
	grunt.registerTask('usemin-all', ['useminPrepare', 'concat', 'uglify', 'cssmin', 'copy:html', 'usemin' ])

	grunt.loadNpmTasks('grunt-open')
	grunt.loadNpmTasks('grunt-contrib-connect')

	grunt.loadNpmTasks('grunt-contrib-uglify')
	grunt.loadNpmTasks('grunt-contrib-concat')
	grunt.loadNpmTasks('grunt-contrib-copy')
	grunt.loadNpmTasks('grunt-contrib-clean')
	grunt.loadNpmTasks('grunt-usemin')

	grunt.loadNpmTasks('grunt-contrib-watch')
	grunt.loadNpmTasks('grunt-contrib-less')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-cssmin')
	grunt.loadNpmTasks('grunt-contrib-htmlmin')