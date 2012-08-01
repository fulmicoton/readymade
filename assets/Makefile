ifdef extra_makefile
   include $(extra_makefile)
endif


${build_path}/%.js: %.coffee
	mkdir -p `dirname $@`
	coffee -o `dirname $@` -c $^ 


${build_path}/%.html.copy: %.html
	mkdir -p `dirname $@`
	cp $^ $@

##############################
# CoffeeScript
# (.coffee) -> (.js)
${build_path}/%.js: %.coffee
	mkdir -p `dirname $@`
	coffee -o `dirname $@` -c $^ 

##############################
# Coco
# (.coco) -> (.js)
${build_path}/%.js: %.coco
	mkdir -p `dirname $@`
	coco -c $^


##############################
# LiveScript
# (.ls) -> (.js)
${build_path}/%.js: %.ls
	mkdir -p `dirname $@`
	livescript -c $^

##############################
# Uglify-js
# (.js) -> (.min.js)
${build_path}/%.min.js: %.js
# requiring intermediate file
${build_path}/%.min.js: ${build_path}/%.js
	mkdir -p `dirname $@`
	uglifyjs -o $@ $^


##############################
# Less CSS
# (.less) -> (.css)
${build_path}/%.css: %.less
	mkdir -p `dirname $@`
	lessc $^ $@

##############################
${build_path}/templates.js: %/mustaches
	mkdir -p `dirname $@`
	hulk $^/* > $@

##############################
#  Sass 
# (.scss) -> (.css)
${build_path}/%.css: %.scss
	mkdir -p `dirname $@`
	sass $^ $@

# (.sass) -> (.css)
${build_path}/%.css: %.sass
	mkdir -p `dirname $@`
	sass $^ $@

##############################
# Stylus
# (.styl) -> .css
${build_path}/%.css: %.styl
	mkdir -p `dirname $@`
	stylus -o `dirname $@` $^

##############################
# Markdown (via markitup)
# (.md) + (.jade) ->(.html)
${build_path}/%.html: %.md %.jade
	mkdir -p `dirname $@`
	markitup --unsafe -t $(word 2,$^) $< --output `dirname $@`

# (.md) + (default.jade) ->(.html)
.SECONDEXPANSION:
${build_path}/%.html: %.md $$(dir %)default.jade 
	mkdir -p `dirname $@`
	markitup --unsafe -t $(word 2,$^) $< --output `dirname $@`

# (.md) -> (.html)
# Fallback to markdown default template if template does not exists
${build_path}/%.html: %.md
	mkdir -p `dirname $@`
	markitup --unsafe -t ${ASSET_PATH}/readymademd.jade $< --output `dirname $@`

# (.md) -> (.html)
# Fallback to markdown default template if template does not exists
${build_path}/%: %
	mkdir -p `dirname $@`;
	cp $^ $@;


${build_path}/%.ico: %.png
	mkdir -p `dirname $@`
	convert $^ -resize 16x16! $@

${build_path}/%.ico: ${ASSET_PATH}/%.ico
	mkdir -p `dirname $@`
	cp $^ $@


