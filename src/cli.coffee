Server = require '../lib/server'
Builder = require '../lib/builder'
path = require 'path'

HOST = "localhost"
PORT = 10000


DEFAULT_MAKEFILE_PATH = path.join __dirname, '../assets/Makefile'
MAKEFILE_PATH = DEFAULT_MAKEFILE_PATH

console.log "Listening on " + HOST + ":" + PORT

builder = new Builder MAKEFILE_PATH
server = new Server HOST, PORT, builder

server.run()
