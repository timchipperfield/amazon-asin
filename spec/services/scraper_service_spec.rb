require 'rails_helper'

RSpec.describe ScraperService, type: :model do
  subject(:scraper) { described_class.new(asin: asin) }

  describe "#scrape" do
    context "when a real asin is passed to the service" do
      context "when asin matches html layout #1 (baby)", vcr: {cassette_name: "banana_toothbrush_request"} do
        let(:asin) { "B002QYW8LW" }

        it "returns a product hash", :aggregate_failures do
          scraped_content = scraper.scrape
          expect(scraped_content[:category]).to eq("Baby Products")
          expect(scraped_content[:rank]).to eq("#28 in Baby")
          expect(scraped_content[:title]).to include("Baby Banana Infant Training Toothbrush and Teether")
          expect(scraped_content[:dimensions]).to eq("4.3 x 0.4 x 7.9 inches")
        end
      end

      context "when asin matches html layout #2 (cell phones)", vcr: {cassette_name: "car_cell_holder_request"} do
        let(:asin) { "B073R68TSH" }

        it "returns a product hash", :aggregate_failures do
          scraped_content = scraper.scrape
          expect(scraped_content[:category]).to eq("cell Phones")
          expect(scraped_content[:rank]).to eq("#34 in Cell Phones & Accessories")
          expect(scraped_content[:title]).to include("Beam Electronics Universal Smartphone Car Air Vent Mount Holder")
          expect(scraped_content[:dimensions]).to eq("2.7 x 3.4 x 5.5 inches")
        end
      end

      context "when asin matches html layout #3 (computers)", vcr: {cassette_name: "refurbished_laptop_request"} do
        let(:asin) { "B06XD3LXXK" }

        it "returns a product hash", :aggregate_failures do
          scraped_content = scraper.scrape
          expect(scraped_content[:category]).to eq("Electronics")
          expect(scraped_content[:rank]).to eq("#92 in Computers & Accessories")
          expect(scraped_content[:title]).to include("Acer Flagship CB3-532 15.6")
          expect(scraped_content[:dimensions]).to eq("10.1 x 15.1 x 1 inches")
        end
      end
    end
  end

  context "when a fake asin is pased to the service", vcr: {cassette_name: "bad_asin_request"} do
    let(:asin) { "B002QYW8LW92" }

    it "creates an empty hash with no error", :aggregate_failures do
      scraped_content = scraper.scrape
      expect(scraped_content[:category]).to eq("")
      expect(scraped_content[:rank]).to eq("")
      expect(scraped_content[:title]).to include("")
      expect(scraped_content[:dimensions]).to eq("")
    end
  end
end
