require 'rails_helper'

RSpec.describe 'vistiting the list of products', type: :feature do
  describe "GET index" do
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
end
