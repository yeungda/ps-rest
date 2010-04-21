# ps-rest 
ps-rest provides a project skeleton for creating a static web client using [haml][1], [sass][2] and [coffee-script][3].

## development web server
client.rb is web server that generates your client resources as you request them.  Changes to the client are just a browser refresh away.  Start this up and point your browser to http://localhost:4567/.

## compiler
compile.rb compiles the client to a directory of your choosing.  The compiled result will not contain any haml, sass, or coffee-script, just html, css and javascript.

## dependencies
ruby is required, along with the following gems:

  - compass
  - sinatra
  - rack
  - haml

ant is required if you want to use the build.xml.


  [1]: http://haml-lang.com/
  [2]: http://sass-lang.com/
  [3]: http://coffeescript.org/
