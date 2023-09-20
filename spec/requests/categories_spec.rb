# spec/controllers/categories_controller_spec.rb

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:valid_attributes) { { name: 'Test Category', icon: 'icon.png' } }
  let(:invalid_attributes) { { name: '', icon: 'icon.png' } }

  describe 'GET #index' do
    before do
      # Create a user and sign them in
      @user = User.create(name: 'foodie', email: 'f@example.com', password: '123456', password_confirmation: '123456')
      sign_in @user
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe 'POST #create' do
    before do
      # Create a user and sign them in
      @user = User.create(name: 'foodie', email: 'f@example.com', password: '123456', password_confirmation: '123456')
      sign_in @user
    end
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: valid_attributes.merge(user_id: @user.id) }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the index page' do
        post :create, params: { category: valid_attributes.merge(user_id: @user.id) }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: invalid_attributes }
        end.not_to change(Category, :count)
      end

      it 'renders the new template' do
        post :create, params: { category: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  # Add more test cases for other controller actions (show, destroy, edit, update) as needed
end
