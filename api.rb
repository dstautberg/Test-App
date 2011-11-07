require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require "./netflix_scraper"

get '/' do
  erb :index
end

get "/category/:category" do |category|
  JSON(NetflixScraper.shows_for_category(category))
end

get "/search/:text" do |text|
  JSON(NetflixScraper.search_shows(text))
end
