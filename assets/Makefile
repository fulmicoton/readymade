%.js: %.coffee
	coffee -c $^

%.css: %.css
	lessc $^ $@

# compiles html files using markitup
%.html: %.md %.jade
	markitup -t $(word 2,$^)  $< 

# Fallback to default if the specific template does not exists.
%.html: %.md layout.jade
	markitup -t $(word 2,$^) $<

# Fallback to markdown default template if template does not exists
%.html: %.md layout.jade
	markitup $<


%: %
