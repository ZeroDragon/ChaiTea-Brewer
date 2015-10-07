require 'consolecolors'
program = require 'commander'
mkdirp = require 'mkdirp'
fs = require 'fs'

templateDir = __dirname+'/../templates'

program
	.option '-n, --name [value]', 'Name your app', null
program.on '--help', ->
	console.log ' Examples:'.yellow
	console.log ''
	console.log "	$ #{'chaitea-brewer'.green} name-of-my-app"
	console.log "	$ #{'chaitea-brewer'.green} -n name-of-my-app"
	console.log ''
program.parse process.argv

if !program.name? and !program.args[0]?
	program.help()
	process.exit 0

appName = program.name ?= program.args[0]

console.log ''
console.log "==================".red
console.log "  ChaiTea Brewer ".green
console.log "==================".red
console.log "\nCreating app #{appName.toUpperCase().magenta}\n"
console.log "Install dependences:".green
console.log "	$ cd #{appName} && npm install\n"
console.log "Run (development):".yellow
console.log "	$ npm test\n"
console.log "Run (production) ".green+"[requires coffeescript installed globally]".red+":".green
console.log "	$ npm start\n"

###*
 * Sends the file from the templates to the destination
 * @param  {string} path path to file in templates
 * @param  {string} file name of file
 * @return {boolean} return true on success, dies on error
###
deployfile = (path,file,treatment)->
	unless treatment?
		treatment = (file)-> return file
	filedata = treatment fs.readFileSync("#{templateDir}#{path}#{file}",{encoding:'utf8'})
	mkdirp.sync "#{appName}#{path}"
	fs.writeFileSync "#{appName}#{path}#{file}", filedata, {encoding:'utf8'}
	return true

###*
 * The files to deploy
 * @type {Array}
###
toDeploy = [
	{
		path : '/app/assets/images/'
		file : 'test.png'
	}
	{
		path : '/app/assets/scripts/'
		file : 'jquery.js'
	}
	{
		path : '/app/assets/scripts/'
		file : 'main.coffee'
	}
	{
		path : '/app/assets/styles/'
		file : 'main.styl'
	}
	{
		path : '/app/controllers/'
		file : 'main_controller.coffee'
	}
	{
		path : '/app/models/'
		file : 'users_model.coffee'
	}
	{
		path : '/app/views/main/'
		file : 'index.jade'
	}
	{
		path : '/app/views/'
		file : '404.jade'
	}
	{
		path : '/'
		file : 'app.coffee'
	}
	{
		path : '/'
		file : 'config.json'
	}
	{
		path : '/'
		file : 'nodemon.json'
	}
	{
		path : '/'
		file : 'routes.coffee'
	}
	{
		path : '/'
		file : 'package.json'
		treatment : (file)-> return file.replace 'APPNAME', appName
	}
]

for d in toDeploy
	deployfile d.path,d.file, d.treatment
