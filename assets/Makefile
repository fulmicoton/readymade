# CoffeeScript
%.js: %.coffee
	coffee -c $^

# Uglify-js
%-min.js: %.js
	uglifyjs -o $@ $^

# Coco
%.js: %.coco
	coco -c $^

# LiveScript
%.js: %.ls
	livescript -c $^



# Less CSS
%.css: %.less
	lessc $^ $@

# Sass (.sass)
%.css: %.scss
	sass $^ $@

# Sass (.sass)
%.css: %.sass
	sass $^ $@





# compiles html files using markitup
%.html: %.md %.jade
	markitup -t $(word 2,$^) $< --output `dirname $@`

# Fallback to default if the specific template does not exists.
%.html: %.md layout.jade
	markitup -t $(word 2,$^) $< --output `dirname $@`

# Fallback to markdown default template if template does not exists
%.html: %.md
	echo "here"
	echo ${ASSET_PATH}	
	markitup $< --output `dirname $@`

%: %

favicon.ico: ${ASSET_PATH}/favicon.ico
	cp $^ $@


