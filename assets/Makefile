# CoffeeScript
%.js: %.coffee
	coffee -c $^

# Uglify-js
%.min.js: %.js
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

# Stylus (.styl)
%.css: %.styl
	stylus $^

# compiles html files using markitup
%.html: %.md %.jade
	markitup -t $(word 2,$^) $< --output `dirname $@`

# Fallback to default if the specific template does not exists.
%.html: %.md layout.jade
	markitup -t $(word 2,$^) $< --output `dirname $@`

# Fallback to markdown default template if template does not exists
%.html: %.md ${ASSET_PATH}/readymademd.jade ${ASSET_PATH}/readymademd.css
	markitup -t ${ASSET_PATH}/readymademd.jade $< --output `dirname $@`

%: %

favicon.ico: ${ASSET_PATH}/favicon.ico
	cp $^ $@


