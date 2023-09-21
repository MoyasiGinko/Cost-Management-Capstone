# spec/models/transaction_spec.rb

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      user = User.create(email: 'user@example.com', password: 'password')
      transaction = Transaction.new(user:)
      expect(transaction.user).to eq(user)
    end

    it 'belongs to a category' do
      category = Category.create(icon: 'icon.png')
      transaction = Transaction.new(category:)
      expect(transaction.category).to eq(category)
    end
  end
end
