require "rubygems"
require "bundler/setup"
Bundler.require(:default)

# This class retrieves tv shows and movies available for streaming on the Netflix website.
# I used Mechanize because it handles cookies and redirects automatically -- when I tried to use the
# standard Net::HTTP library I got a page back saying that cookies needed to be enabled in the browser.

class NetflixScraper

  def self.new_arrivals
    agent = Mechanize.new
    page = agent.get("http://www.netflix.com/BrowseGenres/Watch_Instantly/gev?siw=1")
    page.search("#mycarousel a").map do |link|
      image = link.children.first
      { "link" => link["href"], "title" => image["alt"], "image_link" => image["src"] }
    end
  end

  def self.search(text)
    uri = URI.escape("http://www.netflix.com/Search?v1=#{text}")
    agent = Mechanize.new
    page = agent.get(uri)
    
    # Grab the relevant nodes in the page
    results = page.search("#searchResultsPrimary .agMovie").map do |node|
      box_image = node.search(".boxShot img").first
      title_link = node.search(".title").children.first
      [box_image, title_link]
    end

    # Filter out results that aren't shows (it sometimes includes names of actors).
    results = results.reject do |box_image, title_link| 
      box_image.nil? or title_link.nil?
    end

    # Map what we have to specific data fields and return it
    results = results.map do |box_image, title_link|
      {"title" => box_image["alt"], "image_link" => box_image["src"], "link" => title_link["href"]}
    end

    results
  end

end
