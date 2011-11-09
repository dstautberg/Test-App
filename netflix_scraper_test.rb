require "rubygems"
require "bundler/setup"
Bundler.require(:default, :test)
require "./netflix_scraper"

class NetflixScraperTest < Test::Unit::TestCase

  def test_shows_for_category
    # Setup some pre-saved html as responses for the web requests
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, "http://www.netflix.com/BrowseSelection", 
                         :body => open("netflix_browse_selection.html").read, 
                         :content_type => "text/html")
    FakeWeb.register_uri(:get, "http://www.netflix.com/BrowseGenres/Comedy/307?siw=1&lnktrk=GID_307", 
                         :body => open("netflix_comedies.html").read, 
                         :content_type => "text/html")
    FakeWeb.register_uri(:get, "http://www.netflix.com/BrowseGenres/Watch_Instantly/gev?siw=1&lnktrk=GID_NR", 
                         :body => open("netflix_new_arrivals.html").read, 
                         :content_type => "text/html")

    list = NetflixScraper.shows_for_category("Comedy")
    assert_equal 18, list.size

    show = list.first
    assert_equal "Kevin Hart: I'm a Grown Little Man", show["title"]
    assert_equal "http://www.netflix.com/Movie/Kevin-Hart-I-m-a-Grown-Little-Man/70111504?trkid=772959", show["link"]
    assert_equal "http://cdn-4.nflximg.com/us/boxshots/large/70111504.jpg", show["image_link"]

    show = list.last
    assert_equal "Katt Williams: The Pimp Chronicles: Pt. 1", show["title"]
    assert_equal "http://www.netflix.com/Movie/Katt-Williams-The-Pimp-Chronicles-Pt.-1/70056663?trkid=772959", show["link"]
    assert_equal "http://cdn-3.nflximg.com/us/boxshots/large/70056663.jpg", show["image_link"]

    list = NetflixScraper.shows_for_category("New Arrivals")
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

  def test_search_shows
    saved_response = open("netflix_search_simpsons.html").read
    FakeWeb.allow_net_connect = false
    FakeWeb.register_uri(:get, %r|http://www.netflix.com/.*|, :body => saved_response, :content_type => "text/html")

    list = NetflixScraper.search_shows("simpsons")
    assert_equal 8, list.size

    show = list.first
    assert_equal "The Simpsons", show["title"]
    assert_equal "http://www.netflix.com/Movie/The-Simpsons/70143813?strkid=2011453118_0_0&lnkctr=srchrd-sr&strackid=6f24e0f0129e811f_0_srl&trkid=222336", show["link"]
    assert_equal "http://cdn-3.nflximg.com/us/boxshots/large/70143813.jpg", show["image_link"]

    show = list.last
    assert_equal "Simpsons Gone Wild", show["title"]
    assert_equal "http://www.netflix.com/Movie/Simpsons-Gone-Wild/70001380?strkid=2011453118_7_0&lnkctr=srchrd-sr&strackid=6f24e0f0129e811f_7_srl&trkid=222336", show["link"]
    assert_equal "http://cdn-0.nflximg.com/us/boxshots/large/70001380.jpg", show["image_link"]
  end

end
