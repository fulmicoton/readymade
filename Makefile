COFFEE_FILES=${shell cd src && ls *.coffee}
JS_FILES=${COFFEE_FILES:coffee=js}
TARGETS:=$(addprefix lib/,${JS_FILES})

all: bin/readymade

lib/%.js: src/%.coffee
	coffee -o lib -c $< 

doc: doc/index.html doc/css/readymade.css
	@echo "Building doc"

doc/%:
	readymade build $@

bin/readymade: ${TARGETS}
	echo "#!/usr/bin/env node" > bin/readymade
	cat lib/cli.js >> bin/readymade
	chmod +x bin/readymade

publish: all
	npm publish .
