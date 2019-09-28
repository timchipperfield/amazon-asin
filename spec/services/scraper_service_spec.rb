require 'rails_helper'

RSpec.describe ScraperService, type: :model do
  subject(:scraper) { described_class.new(asin: asin) }

  describe "#scrape" do

    context "when a real asin is passed to the service", vcr: {cassette_name: "success_request"} do
      let(:asin) { "B002QYW8LW" }

      it "returns a product hash", :aggregate_failures do
        scraped_content = scraper.scrape
        expect(scraped_content[:category]).to eq("Baby Products")
        expect(scraped_content[:rank]).to eq("#28 in Baby")
        expect(scraped_content[:title]).to eq("Baby Banana Infant Training Toothbrush and Teether")
      end
    end

  end
end
