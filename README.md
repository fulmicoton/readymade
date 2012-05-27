Readymade
=====================================





What is it?
-------------------------------------

**readymade** is for webprogrammers.
In addition to static files, some of your assets (JavaScript, CSS, Images, ...) have to be compiled before being served to your browser.

**readymade** typically replaces the **-watch** solution, or the plugin in your web framework by a simple generic solution for all of your assets. It handles creating new directories, and chains of compilation (e.g. if want my coffeescript to be compiled, and then minified).

**readymade** makes it easy to have those compiled on the fly 
when requested and when your source files have been modified.
Typically the following are handled by default by
readymade :

- [CoffeeScript](http://coffeescript.org/)
- [Coco](http://satyr.github.com/coco/)
- [LiveScript](http://gkz.github.com/LiveScript/) 
- [Less](http://lesscss.org/)
- [Sass](http://sass-lang.com/)
- [uglifyJS](https://github.com/mishoo/UglifyJS)
- [Markdown via Markitup](https://github.com/nathan-lafreniere/markitup)

You may extend this list by editing a Makefile of your own.
Once started, readymade acts like a web server. 






How to install / how to use ?
-------------------------------------

First, readymade requires you to have installed beforehands :

- make (probably already on your computer if you're using Linux or MacOS)
- NodeJS
- npm
- the command-line compiler for the file you want to serve.


To install **readymade**, you first need to have 
[NodeJS](http://nodejs.org/#download) and npm installed on your computer.

Once down, just run :
  
	npm install readymade -g

Then have readymade serve all your files on http://localhost:10000/ by running :

	readymade serve

Once done, if you have a
	
	media/js/toto.coffee

and your browser requests for

	media/js/toto.js

ReadyMade will compile your CoffeeScript file into JavaScript and serve it. For more information about available options just hit

	readymade help
