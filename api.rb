require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require "./show"

get '/' do
  erb :index
end

get '/api' do
  JSON(Show.list)
end
