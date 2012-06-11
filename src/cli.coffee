Server = require '../lib/server'
Builder = require '../lib/builder'
cli_action = require '../lib/cli_action'
style = require '../lib/style'
path = require 'path'
terminal = require 'color-terminal'
fs = require 'fs'

open_target_file = (targets_filepath)->
    targets_content = fs.readFileSync targets_filepath, 'utf-8'
    lines = targets_content.split "\n"
    targets = ( line.trim() for line in lines )
    ( target for target in targets when target )

argument_parser = cli_action
    
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
            terminal.color(style.URL)
                    .write(server.url())
                    .reset()
                    .nl()
        options: ->
            @options 'f',
                alias : 'makefile'
                default : undefined
            .describe("f","Use a custom Makefile.")
            .options 'p', 
                alias : 'port'
                default : 10000
            .describe("p","ReadyMade Server port.")
            .options 'h', 
                alias : 'host'
                default : 'localhost'
            .describe("h","ReadyMade Server host.")
            .options 'd', 
                alias : 'dest'
                default : './.readymade'
            .describe("d","Build directory.")
            .usage("""
            Usage:
            \treadymade server -h [host] -p [port] -f [Makefile]
            """)
        description: "launch readymade's http server"
    
    build:
        handle: (options)->
            builder = new Builder
                makefile_path: options.makefile
                build_path: options.dest
            if options.targets?
                targets = open_target_file options.targets
            else
                targets = options._
            builder.build_targets targets, (->), (args...)-> console.log args...
        options: ->
            @options 'f',
                alias : 'makefile'
                default : undefined
            .describe("f","Use a custom Makefile.")
            @options 't',
                alias : 'targets'
                default : null
            .describe("t","Target file.")
            .options 'd', 
                alias : 'dest'
                default : '.'
            .describe("d","Build directory.")
            .usage("""Usage:
            \treadymade build -t target file
            \treadymade build <file1> <file2> <...>
            """)
        description: "launch readymade's http server"

    help:
        handle: (options)->
            if options._.length == 1
                action_id = options._.shift()
                @help_on_action action_id
            else
                terminal.nl()
                        .write("  To get specific help, run :").nl()
                        .write("  # ")
                        .color({ foreground: "blue" })
                        .write("readymade help ")
                        .color(style.LABEL)
                        .write("<command>")
                        .reset()
                        .nl(2)
                @help()
        options: ->
            this
        description: "display help for each command"
    

argument_parser.parse()
 

