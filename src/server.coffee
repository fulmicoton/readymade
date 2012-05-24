http = require 'http'
fs = require 'fs' 
path = require 'path'
mime = require 'mime'
jade = require 'jade'
path = require 'path'


ROOT_PATH = path.join __dirname, '../'

load_template_sync = (rel_path)->
    filepath = path.join ROOT_PATH, rel_path
    template_data = fs.readFileSync filepath, 'utf-8'
    jade.compile template_data, {filename: filepath}

TEMPLATES =
    directory_listing : load_template_sync 'assets/directory_listing.jade'
    error404 : load_template_sync 'assets/error404.jade'

serve_directory_listing = (response, directory_path)->
    response.writeHead 404
    fs.readdir directory_path, (err, files)->
        directory_listing = TEMPLATES.directory_listing
            directory_path: directory_path
            files: files
        response.end directory_listing

serve_static_file = (response,filepath)->
    try
        if path.existsSync filepath
            stat =  fs.statSync filepath
            if stat.isDirectory()
                serve_directory_listing response,filepath
            else
                content_type =  mime.lookup filepath
                response.writeHead 200,
                    'content-type': content_type
                file = fs.createReadStream filepath
                file.pipe response
        else
            response.writeHead 404
            response.end TEMPLATES.error404
                filepath: filepath
    catch error
        response.writeHead 500
        response.end "Error "+error_msg

class Server

    constructor: (@host,@port,@builder)->
        
    handle: (request, response)->
        response.setHeader "Access-Control-Allow-Origin", "*"
        url = request.url
        console.log 'GET ', url
        url_base = url.split '?', 1
        filepath = '.' + url_base
        serve_file = (filepath)->
            serve_static_file response,filepath
        failure_callback = (error_msg)->
            response.writeHead 404
            response.end TEMPLATES.error404
                filepath: filepath
                error_msg: error_msg
        @builder.build filepath, serve_file, failure_callback
        
    run: ->
        server = http.createServer (args...)=>@handle(args...)
        server.listen(@port)

module.exports = Server
