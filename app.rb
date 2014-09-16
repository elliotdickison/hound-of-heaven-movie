# Bundler
require 'rubygems'
require 'bundler'
Bundler.require

configure :development do

  # Not efficient, but easy-peasy
  require 'webrick'
  set :server, 'webrick'

  # Output errors
  set :dump_errors, true
end

# Set the views folder
set :views, Proc.new { File.join(root, 'app', 'views') }

# Go to the blog by default
get '/' do
  redirect '/home'
end

get '/home' do
  erb :front
end

get '/about' do
  erb :about
end

get '/poem' do
  erb :poem
end

get '/stills' do
  erb :stills
end

get '/contact' do
  erb :contact
end

not_found do
  redirect '/404.html'
end