# spec/controllers/welcome_controller_spec.rb

require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renders without a layout' do
      get :index
      expect(response).to have_rendered(layout: nil)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
