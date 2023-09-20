# spec/controllers/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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

  let(:valid_attributes) { { name: 'Test Category', icon: 'icon.png' } }
  let(:invalid_attributes) { { name: '', icon: 'icon.png' } }

  describe 'GET #index' do
    it 'returns http success' do
      sign_in user # Sign in the user before the request
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new category' do
        sign_in user # Sign in the user before the request
        expect do
          post :create, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the index page' do
        sign_in user # Sign in the user before the request
        post :create, params: { category: valid_attributes }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        sign_in user # Sign in the user before the request
        expect do
          post :create, params: { category: invalid_attributes }
        end.not_to change(Category, :count)
      end

      it 'renders the new template' do
        sign_in user # Sign in the user before the request
        post :create, params: { category: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
