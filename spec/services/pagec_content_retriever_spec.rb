require 'rails_helper'

RSpec.describe PageContentRetrieverService, type: :model do
  subject(:content_retriever) { described_class.new(asin: asin) }

  describe "#scrape" do
    context "when a real asin is passed to the service" do
      context "when asin matches html layout #1 (baby)", vcr: {cassette_name: "banana_toothbrush_request"} do
        let(:asin) { "B002QYW8LW" }

        it "returns contents of a page" do
          contents = content_retriever.get_content
          expect(contents).to be_a(Nokogiri::HTML::Document)
        end
      end
    end
  end
end
