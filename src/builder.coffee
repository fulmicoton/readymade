child_process = require 'child_process'
path = require 'path'
growl = require 'growl'



NODE_BIN_PATH = "./node_modules/.bin/"

extend=(c, objs...)->
    for obj in objs
        for k,v of obj
            c[k] = v
    c

ASSET_PATH = path.join __dirname, '../assets/'
ENVIRONMENT = extend {}, process.env, 'ASSET_PATH': ASSET_PATH
ENVIRONMENT.PATH = (ENVIRONMENT.PATH ? "") + ":" + NODE_BIN_PATH

class Builder
    
    constructor: (@parameters)->
    
    build: (target, success, failure)->
        make_argv = [ '-f', @parameters.makefile_path, target ]
        ENVIRONMENT.build_path = @parameters.build_path
        make_process = child_process.spawn 'make', make_argv, env: ENVIRONMENT
        error_msg = ""
        make_process.stderr.on "data",(data)->
            error_msg += data.toString()
        make_process.on 'exit', (code)=>
            if (code == 0)
                success target
            else
                @onError
                    msg: error_msg
                    target: target
                failure error_msg
    
    onError: (options)->
        console.log options.msg
        growl? options.target + " build failed."

module.exports = Builder
