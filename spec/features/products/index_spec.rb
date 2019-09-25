require 'rails_helper'

RSpec.describe 'vistiting the list of products', type: :feature do
  describe "GET index" do
    context "when there are products" do
      let(:title) { "Ferrari Enzo" }
      let(:product) { create(:product, title: title) }
      before { product }

      it "shows the product" do
        visit '/products'

        expect(page).to have_content(title)
      end
    end
  end
end
