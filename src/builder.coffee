child_process = require 'child_process'
path = require 'path'
growl = require 'growl'
style = require './style'
terminal = require 'color-terminal'
rjust = require('./utils').rjust
extend = require('./utils').extend

NODE_BIN_PATH = "./node_modules/.bin/"
ASSET_PATH = path.join __dirname, '../assets/'
ENVIRONMENT = extend {}, process.env, 'ASSET_PATH': ASSET_PATH
ENVIRONMENT.PATH = (ENVIRONMENT.PATH ? "") + ":" + NODE_BIN_PATH


DEFAULT_MAKEFILE_PATH = path.join __dirname, '../assets/Makefile'

class Builder
    
    constructor: (@parameters)->
    
    build: (rel_path, success, failure)->
        target = path.join @parameters.build_path, rel_path
        make_argv = [ '-f', DEFAULT_MAKEFILE_PATH, target ]
        ENVIRONMENT.build_path = @parameters.build_path
        if @parameters.makefile_path?
            ENVIRONMENT.extra_makefile = @parameters.makefile_path
        make_process = child_process.spawn 'make', make_argv, env: ENVIRONMENT
        error_msg = ""
        make_process.stderr.on "data",(data)->
            error_msg += data.toString()
        make_process.on 'exit', (code)=>
            if (code == 0)
                success target
            else
                failure target, error_msg.trim()
    
    build_targets: (targets, success, failure)->
        build_success = (target)->
            terminal.color(foreground: "green").write("[ OK ]").reset().nl()
            pop_and_build_one()
        build_failure = (target,error_msg)->
            terminal.color(foreground: "red").write("[FAIL]").reset().nl()
            terminal.write error_msg
            failure()
        pop_and_build_one = =>
            if target = targets.shift()
                terminal.write rjust(target, 30)
                @build target, build_success, build_failure
            else
                success()
        pop_and_build_one()


module.exports = Builder
