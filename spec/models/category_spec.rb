# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'is not valid without the presence of a name' do
      category = Category.new(icon: 'icon.png')
      expect(category).not_to be_valid
    end

    it 'is not valid without the presence of an icon' do
      category = Category.new(name: 'Test Category')
      expect(category).not_to be_valid
    end

    it 'is not valid with empty fields' do
      category = Category.new
      expect(category).not_to be_valid
      expect(category.errors[:icon]).to include("can't be blank")
    end

    it 'is valid with valid attributes' do
      user = User.create(name: 'test', email: 'user@example.com', password: 'password',
                         password_confirmation: 'password')
      category = Category.new(user:, name: 'Test Category', icon: 'icon.png') # Pass the user instance, not user.id
      expect(category).to be_valid
    end
  end

  describe 'associations' do
    it 'has many transactions' do
      category = Category.reflect_on_association(:transactions)
      expect(category.macro).to eq(:has_many)
    end
  end
end
