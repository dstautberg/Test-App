require "rubygems"
require "bundler/setup"
Bundler.require(:test)
require "./api"

class ApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_categories
    verify_category "New Arrivals"
    verify_category "Action & Adventure"
    verify_category "Anime & Animation"
    verify_category "Children & Family"
    verify_category "Classics"
    verify_category "Comedy"
    verify_category "Documentary"
    verify_category "Drama"
    verify_category "Faith & Spirituality"
    verify_category "Foreign" 
    verify_category "Gay & Lesbian"
    verify_category "Horror"
    verify_category "Independent"
    verify_category "Music & Musicals"
    verify_category "Romance"
    verify_category "Sci-Fi & Fantasy"
    verify_category "Special Interest"
    verify_category "Sports & Fitness"
    verify_category "Television"
    verify_category "Thrillers"
  end

  def test_searching
    get "/search/breaking"
    verify_response

    get "/search/the%20simpsons"
    verify_response
  end

  private

    def verify_category(category)
      get "/category/#{URI.escape(category)}"
      verify_response
    end

    # Verify that the JSON response included one or more shows, and the fields for each show were not empty
    def verify_response
      result = JSON(last_response.body)
      assert result, "Invalid response: #{last_response.body[0..100]}..."
      assert result.size > 0, " Result did not have any shows: #{result.inspect}"
      result.each do |item|
        assert item["title"], "Bad title for item: #{item.inspect}"
        assert item["title"].size > 0, "Bad title for item: #{item.inspect}"

        assert item["link"], "Bad link for item: #{item.inspect}"
        assert item["link"].size > 0, "Bad link for item: #{item.inspect}"
        assert_equal "http", item["link"][0,4], "Bad link for item: #{item.inspect}"
        
        assert item["image_link"], "Bad image_link for item: #{item.inspect}"
        assert item["image_link"].size > 0, "Bad image_link for item: #{item.inspect}"
        assert_equal "http", item["image_link"][0,4], "Bad image_link for item: #{item.inspect}"
      end
    end
end
