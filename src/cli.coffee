Server = require '../lib/server'
Builder = require '../lib/builder'
cli_action = require '../lib/cli_action'
style = require '../lib/style'
path = require 'path'
terminal = require 'color-terminal'

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
            builder = new Builder
                makefile_path: options.makefile
                build_path: options.dest
            server = new Server
                host: options.host
                port: options.port
                build_path: options.dest
                builder: builder
            server.run()
            terminal.write "Listening on "
            terminal.color(style.URL).write(server.url()).reset().nl()
        options: ->
            @options 'f',
                alias : 'makefile'
                default : DEFAULT_MAKEFILE_PATH
            .describe("f","Use a custom Makefile.")
            .options 'p', 
                alias : 'port'
                default : 10000
            .describe("f","ReadyMade Server port.")
            .options 'h', 
                alias : 'host'
                default : 'localhost'
            .describe("f","ReadyMade Server port.")
            .options 'd', 
                alias : 'dest'
                default : './.readymade'
            .usage('Usage: readymade server -h [host] -p [port] -f [Makefile]')
        description: "launch readymade's http server"


argument_parser.parse()
 

