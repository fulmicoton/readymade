repeat = (n, s=" ")->
	Array(n+1).join(s)

ljust = (s, n)->
	repeat(n-s.length) + s

rjust = (s, n)->
	s + repeat(n-s.length)

extend=(c, objs...)->
    for obj in objs
        for k,v of obj
            c[k] = v
    c

module.exports =
	ljust: ljust
	rjust: rjust
	extend: extend