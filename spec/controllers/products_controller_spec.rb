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
end
