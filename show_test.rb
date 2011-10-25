require './show'
require 'test/unit'
require 'rack/test'
require 'json'

class ShowTest < Test::Unit::TestCase

  def test_parsing_from_html_snippet
    html = %{<a href="http://www.netflix.com/Movie/Futurama-Into-the-Wild-Green-Yonder/70112371?trkid=772959" class="mdpLink" onmouseover="dB(this)"       id="b070112371_0"><img src="http://cdn-1.nflximg.com/us/boxshots/large/70112371.jpg" alt="Futurama: Into the Wild Green Yonder" title="" class="boxShotImg"  ></a>"}

    doc = Nokogiri::XML::DocumentFragment.parse(html)
    link = doc.children.first
    show = Show.from_link_element(link)
    assert show, "Show object was not created"
    assert_equal "Futurama: Into the Wild Green Yonder", show.title
    assert_equal "http://www.netflix.com/Movie/Futurama-Into-the-Wild-Green-Yonder/70112371?trkid=772959", show.link
    assert_equal "http://cdn-1.nflximg.com/us/boxshots/large/70112371.jpg", show.image_link
  end

  def test_parsing_from_page_html
    html = open("test1.html").read
    doc = Nokogiri::HTML.parse(html)
    shows = Show.from_page_document(doc)
    assert shows, "Show were not parsed"
    assert_equal 18, shows.size

    assert_equal "Futurama: Into the Wild Green Yonder", shows[0].title
    assert_equal "http://www.netflix.com/Movie/Futurama-Into-the-Wild-Green-Yonder/70112371?trkid=772959", shows[0].link
    assert_equal "http://cdn-1.nflximg.com/us/boxshots/large/70112371.jpg", shows[0].image_link

    assert_equal "Thomas & Friends: Team up with Thomas", shows[17].title
    assert_equal "http://www.netflix.com/Movie/Thomas-Friends-Team-up-with-Thomas/70116051?trkid=772959", shows[17].link
    assert_equal "http://cdn-1.nflximg.com/us/boxshots/large/70116051.jpg", shows[17].image_link
end

end
