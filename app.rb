require 'sinatra'

get '/' do
  erb :index
end

post '/' do
  @names = params[:names].split(",")
  erb :index
end
