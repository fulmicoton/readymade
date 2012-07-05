extend = require('./utils').extend

default_options = 
    build_path: ".readymade"

middleware = (passed_options)->
    options = extend default_options, passed_options 

    builder = new Builder
        makefile_path: options.makefile
        build_path: options.dest

    server = new Server
        build_path: options.dest
        builder: builder

    (req, res, next)->
        server.handle req, res

module.exports =
    middleware: middleware



