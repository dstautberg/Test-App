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

get "/search/:text" do |text|
  JSON(Show.search(text))
end