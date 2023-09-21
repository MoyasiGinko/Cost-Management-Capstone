# spec/controllers/dashboard_controller_spec.rb

require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) do
    User.create(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  before(:each) do
    sign_in user # Use Devise's sign_in method to sign in the user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns the current user to @user' do
      get :index
      expect(assigns(:user)).to eq(user)
    end

    it 'requires authentication' do
      sign_out user # Sign out the user to test authentication
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'returns a successful response when authenticated' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders with a layout' do
      get :index
      expect(response).to have_rendered(layout: 'application')
    end
  end
end
