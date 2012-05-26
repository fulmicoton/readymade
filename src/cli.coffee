Server = require '../lib/server'
Builder = require '../lib/builder'
cli_action = require '../lib/cli_action'
path = require 'path'


DEFAULT_MAKEFILE_PATH = path.join __dirname, '../assets/Makefile'

argument_parser = cli_action

    help:
        handle: (options)->
            if options._.length == 1
                action_id = options._.shift()
                @help_on_action action_id
            else
                @help "To get specific help, run :\n# readymade help  <command>"
        options: ->
            this
        description: "display help for each command"
    
    serve:
        handle: (options)->
            console.log "Listening on " + options.host + ":" + options.port
            builder = new Builder options.makefile
            server = new Server options.host, options.port, builder
            server.run()
        options: ->
            @options 'f',
                alias : 'makefile'
                default : DEFAULT_MAKEFILE_PATH
            .options 'p', 
                alias : 'port'
                default : 10000
            .options 'h', 
                alias : 'host'
                default : 'localhost'
            .usage('Usage: readymade server -h [host] -p [port] -f [Makefile]')
        description: "launch readymade's http server"


argument_parser.parse()
 

