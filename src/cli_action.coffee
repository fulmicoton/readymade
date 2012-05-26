optimist = require 'optimist'


ljust = (s, n)->
    res = s
    for i in [s.length...n]
        res += " "
    res

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
    
    help:(msg)->
        if msg?
            console.log "-----------------------------------------------"
            console.log msg
            console.log "-----------------------------------------------\n"
        console.log "Available actions are"
        for k,v of @actions
            console.log "  ", ljust(k,25), v.description

module.exports = (actions)->
    new ActionParser actions
