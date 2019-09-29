require 'rails_helper'

RSpec.describe 'vistiting the list of products', type: :feature do
  describe "GET #index" do
    context "when there are products" do
      let(:title) { "Ferrari Enzo" }
      let(:rank) { 4.3 }
      let(:category) { "cars" }
      let(:product) { create(:product, title: title, rank: rank, category: category) }
      before { product }

      it "shows the product" do
        visit '/products'

        expect(page).to have_content(title)
        expect(page).to have_content(rank)
        expect(page).to have_content(category)
      end
    end
  end

  describe "POST #create" do
    before do
      visit '/products'
      fill_in("asin", :with => asin)
      click_on("Submit ASIN")
    end

    context "when a real asin is inputted", vcr: {cassette_name: "banana_toothbrush_request"} do
      let(:asin) { "B002QYW8LW" }

      it "updates the page with the new product" do
        expect(page).to have_content("Product successfully saved!")
        expect(page).to have_content("Baby Banana Infant Training Toothbrush and Teether")
      end
    end

    context "when a false asin is inputted", vcr: {cassette_name: "bad_asin_request"}  do
      let(:asin) { "B002QYW8LW92" }

      it "shows an error message" do
        expect(page).to have_content("Sorry, we can't locate this product")
        expect(page).not_to have_content("Baby Banana Infant Training Toothbrush and Teether")
      end
    end
  end
end
