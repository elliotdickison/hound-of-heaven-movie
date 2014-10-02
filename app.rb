# Bundler
require 'rubygems'
require 'bundler'
require 'pony'
require 'rake'
require 'sinatra'

# Target address for contact form
set :contact_email, 'ejdickison@gmail.com' #'aaronrench@gmail.com'

configure :development do

  # Not efficient, but easy-peasy
  require 'webrick'
  set :server, 'webrick'

  # Output errors
  set :dump_errors, true
end

configure :production do

  # Analytics
  require 'newrelic_rpm'

  # Mail
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

# Set the views folder
set :views, Proc.new { File.join(root, 'app', 'views') }

# Go to the blog by default
get '/' do
  redirect '/home'
end

get '/home' do
  erb :home
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

get '/stills/theater' do
  erb :theater, locals: {index: params[:i]}
end

get '/contact' do
  erb :contact
end

post '/contact' do
  begin
    Pony.mail({
      from: "#{params[:first]} #{params[:last]} <#{params[:email]}>",
      to: settings.contact_email,
      subject: "#{params[:subject]} [HoH Contact Form]",
      body: params[:body]
    })
    success = true
  rescue
    success = false
  end
  erb :contact, locals: {success: success}
end

not_found do
  redirect '/404.html'
end