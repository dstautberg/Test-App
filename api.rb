require 'sinatra'
require 'json'
require './show'

get '/' do
  erb :index
end

get '/api' do
  JSON(Show.list)
end
