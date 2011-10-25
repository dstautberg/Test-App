require "nokogiri"
require 'open-uri'
require 'mechanize'

# This class retrieves the list of new tv shows or movies available for streaming on the Netflix website.

class Show
  attr_accessor :title, :link, :image_link

  NetflixUri = "http://www.netflix.com/BrowseGenres/Watch_Instantly/gev?siw=1"

  def self.list
    # I used Mechanize here because it handles cookies and redirects automatically.  When I tried to use the standard Net::HTTP 
    # library I got a page back saying that cookies needed to be enabled in the browser.
    agent = Mechanize.new
    page = agent.get(NetflixUri)
    # Uncomment this to see what html is being returned:
    # File.open("netflix.html","wt") {|f| f.write(page.body)}
    doc = Nokogiri::HTML.parse(page.body)
    from_page_document(doc)
  end

  def self.from_page_document(doc)
    shows = []
    doc.css("#mycarousel a").each do |link|
      shows << Show.from_link_element(link)
    end
    shows
  end

  def self.from_link_element(link)
    show = Show.new
    show.link = link["href"]
    image = link.children.first
    show.title = image["alt"]
    show.image_link = image["src"]
    show
  end

  def to_json(*a)
    {
      "title" => self.title,
      "link" => self.link,
      "image_link" => self.image_link
    }.to_json(*a)
  end

end
