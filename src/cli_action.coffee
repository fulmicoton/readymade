optimist = require 'optimist'
terminal = require 'color-terminal'
style = require '../lib/style'
ljust = require('./utils').ljust

class ActionParser
    
    constructor: (@actions)->

    parse: (argv=process.argv[2..])->
        try
            if argv.length == 0
                throw "You need to specify an action."
            else
                action_id = argv.shift()
                action = @actions[action_id]
                if action?
                    options = action.options.call(optimist argv).argv
                    action.handle.call this,options
                else
                    throw action_id + " is not a valid action."

        catch error
            @help "! " + error
    
    help_on_action: (action_id)->
        action = @actions[action_id]
        if action?
            argv=process.argv[2..]
            console.log "\n",action.options.call(optimist argv).help()
        else
            throw "Action #{action_id} not available"
    
    help: ()->
        console.log "  Available actions are"
        max_action_length = Math.max.apply(Math, k.length for k,v of @actions)
        for k,v of @actions
            action_label = ljust(k, max_action_length+3)
            terminal.color(style.LABEL)
                .write(action_label)
                .reset()
                .write("   ")
                .write(v.description)
                .nl()
        terminal.nl()

module.exports = (actions)->
    new ActionParser actions
