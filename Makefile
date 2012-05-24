COFFEE_FILES=${shell cd src && ls *.coffee}
JS_FILES=${COFFEE_FILES:coffee=js}
TARGETS:=$(addprefix lib/,${JS_FILES})

all: bin/readymade

lib/%.js: src/%.coffee
	coffee -o lib -c $< 

bin/readymade: ${TARGETS}
	echo "#!/usr/bin/env node" > bin/readymade
	cat lib/cli.js >> bin/readymade
	chmod +x bin/readymade

#uninstall:
#		echo "uninstall"
#		npm uninstall tumbler
#
#ginstall: bin lib
#		npm install ./tumbler -g
#
#install: uninstall bin lib 
#		npm install ./tumbler
#
#lib: 
#		coffee -c tumbler/src/utils.coffee
#		coffee -c tumbler/src/tumbler.coffee
#		mv tumbler/src/tumbler.js tumbler/lib/
#		mv tumbler/src/utils.js tumbler/lib/
#
#test: install
#		coffee tumbler/test/test1.coffee
#		./node_modules/.bin/tumbler tumbler/test/examples/test1.js
#
#runserver: install
#		node node_modules/.bin/tumbler serve 
#
#publish: bin lib
#		npm publish tumbler
