class ScraperService

  attr_reader :doc, :asin

  def initialize(asin:)
    @asin = asin
    @doc = retrieve_doc
  end

  def scrape
    {
      raw_category: doc.at_css('span.a-list-item').text,
    }
  end

  private

  def retrieve_doc
    browser = Watir::Browser.new(:chrome, headless: true)
    browser.goto path
    Nokogiri::HTML.parse(browser.html)
  end

  def path
    @path ||= "http://www.amazon.com/dp/#{asin}"
  end
end
