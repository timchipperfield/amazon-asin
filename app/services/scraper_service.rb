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
      rank: parse_rank(scrape_rank),
      title: parse_title(doc.title),
      dimensions: parse_dimensions(doc.xpath("//*[contains(text(),'Product Dimensions')]/following-sibling::td").text),
      asin: asin
    }
  end

  private

  def scrape_rank
    path = "//*[contains(text(),'Best Sellers Rank')]/following-sibling::td/span[1]/span[1]"
    main_element_path = doc.xpath(path).text

    return main_element_path if main_element_path.present?

    secondary_element_path = doc.at_css("#SalesRank").try(:text)
    return secondary_element_path if secondary_element_path.present?

    doc.xpath("//table[@class='a-keyvalue prodDetTable']/tbody/tr[7]/td").try(:text)
  end

  def retrieve_doc
    browser = Watir::Browser.new(:chrome, headless: true)
    browser.goto(path)
    Nokogiri::HTML.parse(browser.html)
  end

  def path
    @path ||= "http://www.amazon.com/dp/#{asin}"
  end
end
