child_process = require 'child_process'

class Builder
    
    constructor: (@makefile_path)->
        
    build: (target, success, failure)->
        make_argv = [ '-f', @makefile_path, target]
        make_process = child_process.spawn 'make', make_argv
        error_msg = ""
        make_process.stderr.on "data",(data)->
            error_msg += data.toString()
        make_process.on 'exit', (code)->
            console.log "Exiting with code ", code
            if (code == 0)
                success target
            else
                console.log error_msg
                failure error_msg

module.exports = Builder