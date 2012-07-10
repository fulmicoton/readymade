repeat = (n, s=" ")->
	Array(n+1).join(s)

ljust = (s, n)->
	indent = Math.max 1,(n-s.length)
	repeat(indent) + s

rjust = (s, n)->
	indent = Math.max 1,(n-s.length)
	s + repeat indent

extend=(c, objs...)->
    for obj in objs
        for k,v of obj
            c[k] = v
    c

module.exports =
	ljust: ljust
	rjust: rjust
	extend: extend