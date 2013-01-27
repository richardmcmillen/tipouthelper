require 'sinatra'
require 'sinatra/session'

set :session_fail, '/'
set :session_secret, ENV['SESSION_SECRET'] || 'b1gs3cr3t'

get '/' do
  erb :index
end

post '/calculator' do
  if params[:names]
    session_start!
    session[:tipsfor] = Hash.new
    for name in params[:names].split(",")
      session[:tipsfor][name] = []
    end
  end
  if params[:amount] and params[:employee]
    @each = params[:amount].to_f / params[:employee].length
    session_start!
    params[:employee].each_key { |employee| session[:tipsfor][employee].push(@each) }
  end
  erb :calculator
end

get '/calculator' do
  session!
  erb :calculator
end

get '/reset' do
  session_end!
  redirect '/'
end

not_found do
  halt 404, 'Page Not Found Yo!'
end
