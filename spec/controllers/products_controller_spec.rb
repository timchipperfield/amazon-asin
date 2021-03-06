require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#index" do
    before { create_list(:product, 10) }

    it "assigns all of the existing products" do
      get :index
      expect(assigns(:products).count).to eq(10)
      expect(response).to render_template(:index)
    end
  end

  describe "#create" do
    context "when the asin matches a real product", vcr: {cassette_name: "banana_toothbrush_request"} do
      let(:params) { {asin: "B002QYW8LW"} }

      it "creates a new product using the asin page contents" do
        expect { post :create, params: params }.to change(Product, :count).by(1)
        expect(response).to redirect_to(action: :index)
        expect( subject.request.flash[:success] )
      end
    end

    context "when the asin dos not match a real product", vcr: {cassette_name: "bad_asin_request"} do
      let(:params) { {asin: "B06XD3LXXK"} }

      it "redirect back to index" do
        expect { post :create, params: params }.not_to change(Product, :count)
        expect(response).to redirect_to(action: :index)
      end
    end
  end
end
