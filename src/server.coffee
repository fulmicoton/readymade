style = require '../lib/style'
http = require 'http'
fs = require 'fs' 
path = require 'path'
mime = require 'mime'
jade = require 'jade'
path = require 'path'
terminal = require 'color-terminal'

# handling change in API starting node v0.8
existsSync = fs.existsSync || path.existsSync


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
        if existsSync filepath
            stat =  fs.statSync filepath
            if stat.isDirectory()
                serve_directory_listing response,filepath
            else
                content_type =  mime.lookup filepath
                file = fs.createReadStream filepath
                file.pipe response
                response.writeHead 200,
                    'content-type': content_type
        else
            response.writeHead 404
            response.end TEMPLATES.error404
                filepath: filepath
    catch error
        response.writeHead 500
        response.end "Error "+error_msg


class Server

    constructor: (options)->
        @host = options.host
        @port = options.port
        @builder = options.builder
        @build_path = options.build_path
    
    handle: (request, response)->
        response.setHeader "Access-Control-Allow-Origin", "*"
        url = request.url
        url_base = url.split('?', 1)[0]
        rel_path = path.join ".", url_base
        serve_file = (target)->
            terminal.color(style.GET).write('GET   ').reset()
            terminal.color(style.TARGET).write(url).nl().reset()
            serve_static_file response, target
        failure_callback = (target, error_msg)->
            growl? options.target + " build failed."
            terminal.color(style.ERROR).write 'ERROR '
            terminal.color(style.TARGET).write(url).nl().reset()
            terminal.right(2).color(style.TEXT).write(error_msg).nl().reset()
            response.writeHead 404
            response.end TEMPLATES.error404
                filepath: target
                error_msg: error_msg
        @builder.build rel_path, serve_file, failure_callback


    url: ->
        "http://" + @host + ":" + @port

    run: ->
        server = http.createServer (args...)=>@handle(args...)
        server.listen @port, @host

module.exports = Server
