require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require "./netflix_scraper"

get '/' do
  erb :index
end

get '/new_arrivals' do
  JSON(NetflixScraper.new_arrivals)
end

get "/search/:text" do |text|
  JSON(NetflixScraper.search(text))
end