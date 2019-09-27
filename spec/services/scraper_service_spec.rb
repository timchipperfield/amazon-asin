require 'rails_helper'

RSpec.describe ScraperService, type: :model do
  subject(:scraper) { described_class.new(asin: asin) }

  describe "#scrape" do

    context "when a real asin is passed to the service", vcr: {cassette_name: "success_request"} do
      let(:asin) { "B002QYW8LW" }

      it "returns a product hash" do
        expect(scraper.scrape[:raw_category]).to include("Baby Products")
      end
    end

  end
end
