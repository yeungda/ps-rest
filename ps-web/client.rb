require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'compass'
require 'open3'

configure do
  set :views, File.dirname(__FILE__)
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.images_dir = 'images'
  end
  set :haml, { :format => :html5 }
  set :sass, Compass.sass_engine_options
end

content_root = './src/main'

get '/' do
  haml File.join(content_root, 'index.html').intern
end

get %r{/(.*.html)} do |file|
  haml_file = File.join(content_root, file) + '.haml'
  if File.exist?(haml_file)
    return haml File.join(content_root, file).intern
  end
  send_file File.join(content_root, file)
end

get %r{/(.*.txt)} do |file|
  content_type 'text/plain', :charset => 'utf-8'
  send_file File.join(content_root, file)
end

get %r{/(.*.ico)} do |file|
  content_type 'images/x-icon'
  send_file File.join(content_root, file)
end

get %r{/(.*.gif)} do |file|
    send_file File.join(content_root, file)
end

get %r{/(.*.jpg)} do |file|
    send_file File.join(content_root, file)
end

get %r{/(.*.png)} do |file|
    send_file File.join(content_root, file)
end

get %r{/(.*.js)} do |file|
  content_type 'text/javascript', :charset => 'utf-8'
  coffee_file = File.join(content_root, file) + '.coffee'
  if File.exist?(coffee_file)
    return Open3.popen3('coffee --eval --print') do |stdin, stdout, stderr|
      stdin.puts File.open(coffee_file).read()
      stdin.close
      stdout.read
    end
  end
  send_file File.join(content_root, file)
end

get %r{/(.*.css)} do |file|
  content_type 'text/css', :charset => 'utf-8'
  sass_file = File.join(content_root, file) + '.sass'
  if File.exist?(sass_file)
    return sass (File.join(content_root, file).intern)
  end
  send_file File.join(content_root, file)
end