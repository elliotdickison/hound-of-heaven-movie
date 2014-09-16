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

# Setup pony mail
set :contact_email, 'ejdickison@gmail.com'
configure :production do
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

post '/contact' do
  begin
    Pony.mail({
      from: "#{params[:first]} #{params[:last]} <#{params[:email]}>",
      to: settings.contact_email,
      subject: params[:subject],
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