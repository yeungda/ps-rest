require 'rubygems'
require 'haml'
require 'sass'
require 'compass'
require 'open3'
require 'ftools'
require 'find'

target = ARGV[0]

Compass.configuration do |config|
  config.project_path = File.dirname(__FILE__)
  config.images_dir = 'images'
end

def render_haml(src, target)
    template = File.read(src)
    haml_engine = Haml::Engine.new(template)
    File.open(target, "w") do |file|
      file.write(haml_engine.render)
    end
end

def render_sass(src, target)
  File.open(target, "w") do |file|
    file.write(Sass::Files.tree_for(src, Compass.sass_engine_options).render)
  end
end

def render_coffee(src, target)
    File.open(target, "w") do |file|
      javascript = Open3.popen3('coffee --eval --print') do |stdin, stdout, stderr|
        stdin.puts File.open(src).read()
        stdin.close
        stdout.read
      end
      file.write(javascript)
    end
end

Find.find('./src/main') do |path|
  target_path = File.join(target, path.sub('./src/main', ''))
  puts path
  if (File.directory? path) then
    File.makedirs target_path
  elsif (path.end_with? '.haml') then
    render_haml path, target_path.chomp('.haml')
  elsif (path.end_with? '.sass') then
    render_sass path, target_path.chomp('.sass')
  elsif (path.end_with? '.coffee') then
    render_coffee path, target_path.chomp('.coffee')
  else
    File.copy(path, target_path)
  end
end