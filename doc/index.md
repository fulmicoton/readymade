

ReadyMade makes it easier for webdevelopers and designers to work with 
assets that requires compilation : CoffeeScript, Less css, Sass, Stylus, Uglify, markdown ... and obviously all of your static files that don't require compilation (images, css, js, etc.).

I can work as a standalone serve or integrate with ExpressJS.





Serve your file for development
------------------------------------------------

ReadyMade offers you one single solution to compile 
your asset on-the-fly when you are developing.

Contrary to the **-watch** option many compilers offers,
ReadyMade compiles your files when you refresh your browser.
A detailed error page will be served if your file compilation fails.
To get the server running and serve your assets on [localhost:10000](http://localhost:1000/), just cd to your media directory root and run :

    readymade serve


For instance, if you have a CoffeeScript source file in

    ./js/myfile.coffee

and you request for 

    http://localhost:10000/js/myfile.js

Your CoffeeScript file will get compiled and served.

Compiled files are cached (by default in a .readymade directory). The compilation will occur only if it is required.




Build your files for production
------------------------------------------------


You can also build most of assets using one single command.

    readymade build <file1> <file2> ...

You may also write all your targets' path (one per line) in a target file and build all of them at once via

    readymade build -t <your-target-file>

By default, files are compiled in place.  You can define a specific build 
directory by 

    readymade build -t <your-target-file> -d <your-build-dir>


Formats handled by default
------------------------------------


<table>
    <thead>
        <tr>
            <th>Type of asset</th>
            <th>Target file</th>
            <th>Source file</th>
            <th>Compiler installation</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>[CoffeeScript](http://coffeescript.org/)</td>
            <td>.js</td>
            <td>.coffee</td>
            <td class='command'>npm install coffee-script</td>
        </tr>
        <tr>
            <td>[Coco](http://satyr.github.com/coco/)</td>
            <td>.js</td>
            <td>.coco</td>
            <td class='command'>npm install coco</td>
        </tr>
        <tr>
            <td>[LiveScript](http://gkz.github.com/LiveScript/)</td>
            <td>.js</td>
            <td>.ls</td>
            <td class='command'>npm install LiveScript</td>
        </tr>
        <tr>
            <td>[Less](http://lesscss.org/)</td>
            <td>.css</td>
            <td>.less</td>
            <td class='command'>npm install less</td>
        </tr>
        <tr>
            <td>[Sass](http://sass-lang.com/)</td>
            <td>.css</td>
            <td>.scss or .sass</td>
            <td class='command'>gem install sass</td>
        </tr>
        <tr>
            <td>[Stylus](http://learnboost.github.com/stylus/)</td>
            <td>.css</td>
            <td>.styl</td>
            <td class='command'>npm install stylus</td>
        </tr>
        <tr>
            <td>[Uglify JS](https://github.com/mishoo/UglifyJS)</td>
            <td>.min.js</td>
            <td>.js</td>
            <td class='command'>npm install uglifyjs</td>
        </tr>
        <tr>
            <td>[Markdown](https://github.com/nathan-lafreniere/markitup)</td>
            <td>.html</td>
            <td>.md</td>
            <td class='command'>npm install markitup</td>
        </tr>
        <tr>
            <td>[Markdown and Jade](https://github.com/nathan-lafreniere/markitup)</td>
            <td>.html</td>
            <td>.md and .jade</td>
            <td class='command'>npm install markitup</td>
        </tr>
        <tr>
            <td>[Mustache templates<br/>(via Hogan)](http://twitter.github.com/hogan.js/)</td>
            <td>templates.js</td>
            <td>a "mustaches" directory<br/>containing all your templates.</td>
            <td class='command'>npm install markitup</td>
        </tr>
    </tbody>
</table>



How to extend
------------------------

ReadyMade works on Makefile.
You can define extend [its default configuration](https://github.com/poulejapon/readymade/blob/master/assets/Makefile) by writing your own building rule.

For instance, I could define the way to define a rule to copy files to .copy
file by creating and editing readymade.Makefile.

    ##############################
    # Copy file
    # (.*) -> (.*.copy)
    ${build_path}/%.copy: %
        mkdir -p `dirname $@`
        cp $^ $@

This rule will be active if you run either **readymade serve** or
**readymade build** with the -f option :

    readymade serve -f readymade.Makefile





How to install
------------------------

ReadyMade requires [NodeJS](http://nodejs.org/) and [Make](http://fr.wikipedia.org/wiki/Make) to be installed on your computer.
Make comes by default on most Linux Distribution and with XCode on MacOS (dunno about Windows).

Once it is installed, you can install readymade via 

    npm install readymade -g

(You might need to **sudo** your way through this command.)

You will also need to install separately all of the compilers you need.




Integrate with express
-----------------------------------


Readymade is up and running just by adding one line in your app.configure:

    app.configure(function(){
        // ... 
        app.use(require('readymade').middleware({root: "public"}));
        // ... 
    });

Readymade will then server the content within **./public** content on **/public**.
In order to extend readymade with your own building rules, just pass the path to your
makefile with the **makefile** option.

    app.configure(function(){
        // ... 
        var readymadeOptions = {
            root: "public",
            makefile:"./readymade.Makefile"
        };
        app.use(require('readymade').middleware(readymadeOptions));
        // ... 
    }); 

 More help
------------------------------------

Get more information about command-line options via :

    readymade help (action)


