Readymade
=====================================

Readymade is for webprogrammers.
In addition to static files, some of your assets (JavaScript, CSS, Images, ...) have to be compiled before being served to your browser.

Readymade typically replaces the **-watch** solution, or the plugin in your web framework by a simple generic solution for all of your assets. It handles creating new directories, and chains of compilation (e.g. if want my coffeescript to be compiled, and then minified).

Readymade makes it easy to have those compiled on the fly 
when requested and when your source files have been modified.



Which type of asset are handled ?
-------------------------------------

The following assets are handled by default are handled by default by
readymade :

- [[⇥]](http://coffeescript.org/) CoffeeScript :
   
  **.coffee** → **.js**
- [[⇥]](http://satyr.github.com/coco/) Coco :
  
  **.coco** → **.js**
- [[⇥]](http://gkz.github.com/LiveScript/) LiveScript :
  
  **.ls** → **.js**
- [[⇥]](http://lesscss.org/) Less :
  
  **.less** → **.css**
- [[⇥]](http://sass-lang.com/) Sass : 
  
  **.sass**  or **.scss** → **.css**
- [[⇥]](http://learnboost.github.com/stylus/) Stylus
  
  **.styl** → **.css**
- [[⇥]](https://github.com/mishoo/UglifyJS) uglifyJS :
  
  **.js**  → **.min.js**
- [[⇥]](https://github.com/nathan-lafreniere/markitup) Markdown via Markitup 
  
  **.md** → **.html** or **.md** + **.jade**  → **.html** 
- Plain static files which do not require any compilation.

You may extend this list by editing a Makefile of your own.
Once started, readymade acts like a web server. 






How to install / how to use ?
-------------------------------------

First, readymade requires you to have installed beforehands make, nodeJS, npm, and all the command line compiler for the file you want to serve.

Then to install it just run the following command (or sudo it depeding on your npm/node installation):
  
	npm install readymade -g


Then have readymade serve all your files on your [port 10000](http://localhost:10000/) by place yourself in the repertory you want to serve and run :

	readymade serve

Once done, if you have a
	
	media/js/toto.coffee

and your browser requests for

	media/js/toto.js

ReadyMade will compile your CoffeeScript file into JavaScript and serve it. For more information about available options just hit

	readymade help

