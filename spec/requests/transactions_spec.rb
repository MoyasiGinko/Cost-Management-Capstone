# spec/controllers/transactions_controller_spec.rb

require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
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
    it 'returns http success' do
      category = Category.create!(name: 'Test Category', icon: 'icon.png', user:)
      get :index, params: { category_id: category.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'assigns a new transaction' do
      category = Category.create!(name: 'Test Category', icon: 'icon.png', user:)
      get :new, params: { category_id: category.id }
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end

    it 'renders the new template' do
      category = Category.create!(name: 'Test Category', icon: 'icon.png', user:)
      get :new, params: { category_id: category.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new transaction with valid parameters' do
      category = Category.create!(name: 'Test Category', icon: 'icon.png', user:)
      expect do
        post :create, params: { category_id: category.id, transaction: { name: 'Test Transaction', amount: 100 } }
      end.to change(Transaction, :count).by(1)
    end
  end

  # Add more test cases for other controller actions (show, destroy, edit, update) as needed
end
