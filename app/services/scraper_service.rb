class ScraperService
  include ContentParsable
  attr_reader :doc, :asin

  def initialize(asin:)
    @asin = asin
    @doc = retrieve_doc
  end

  def scrape
    {
      category: parse_category(doc.at_css("span.a-list-item").text),
      rank: parse_rank(doc.at_css("#SalesRank").text),
      title: parse_title(doc.at_css("meta[name='description']").values.last)
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
