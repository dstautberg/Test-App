require "rubygems"
require "bundler/setup"
Bundler.require(:test)
require "./api"

class ApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_show_list
    get '/api'
    result = JSON(last_response.body)
    assert result, "Invalid response: #{last_response.body[0..100]}..."
    assert result.size > 0, "Result did not have any shows: #{result.inspect}"
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
