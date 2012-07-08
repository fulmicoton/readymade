extend = require('./utils').extend
Builder = require('./builder')
Server = require('./server')

default_options = 
    build_path: ".readymade"
    media_root: 'public'

middleware = (passed_options)->
    
    options = extend default_options, passed_options 

    builder = new Builder
        makefile_path: options.makefile
        build_path: options.build_path

    prefix = "/" + options.media_root + "/"
    server = new Server
        build_path: options.build_path
        builder: builder

    (req, res, next)->
        if req.url.indexOf(prefix) == 0
            server.handle req, res
        else
            next()


module.exports =
    middleware: middleware



