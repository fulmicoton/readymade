repeat = (n, s=" ")->
	Array(n+1).join(s)

ljust = (s, n)->
	repeat(n-s.length) + s

rjust = (s, n)->
	s + repeat(n-s.length)

module.exports =
	ljust: ljust
	rjust: rjust