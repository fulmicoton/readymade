child_process = require 'child_process'
path = require 'path'


extend=(c, objs...)->
    for obj in objs
        for k,v of obj
            c[k] = v
    c

ASSET_PATH = path.join __dirname, '../assets/' 
ENVIRONMENT = extend {}, process.env, 'ASSET_PATH': ASSET_PATH


class Builder
    
    constructor: (@makefile_path)->
        
    build: (target, success, failure)->
        make_argv = [ '-f', @makefile_path, target]
        make_process = child_process.spawn 'make', make_argv, env: ENVIRONMENT
        error_msg = ""
        make_process.stderr.on "data",(data)->
            error_msg += data.toString()
        make_process.on 'exit', (code)->
            if (code == 0)
                success target
            else
                console.log error_msg
                failure error_msg

module.exports = Builder