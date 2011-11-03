require "rubygems"
require "bundler/setup"
Bundler.require(:test)
require "./netflix_scraper"

class NetflixScraperTest < Test::Unit::TestCase

  def test_new_arrivals
    saved_response = open("netflix_new_releases.html").read
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, %r|http://www.netflix.com/.*|, :body => saved_response, :content_type => "text/html")
    
    list = NetflixScraper.new_arrivals
    assert list, "Shows were not parsed"
    assert_equal 18, list.size

    show = list.first
    assert_equal "Futurama: Into the Wild Green Yonder", show["title"]
    assert_equal "http://www.netflix.com/Movie/Futurama-Into-the-Wild-Green-Yonder/70112371?trkid=772959", show["link"]
    assert_equal "http://cdn-1.nflximg.com/us/boxshots/large/70112371.jpg", show["image_link"]

    show = list.last
    assert_equal "Thomas & Friends: Team up with Thomas", show["title"]
    assert_equal "http://www.netflix.com/Movie/Thomas-Friends-Team-up-with-Thomas/70116051?trkid=772959", show["link"]
    assert_equal "http://cdn-1.nflximg.com/us/boxshots/large/70116051.jpg", show["image_link"]
  end

  def test_searching
    saved_response = open("netflix_search_simpsons.html").read
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, %r|http://www.netflix.com/.*|, :body => saved_response, :content_type => "text/html")

    list = NetflixScraper.search("simpsons")
    assert_equal 8, list.size
  end

end
