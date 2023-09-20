require 'rails_helper'

RSpec.describe 'transactions/new', type: :view do
  include Devise::Test::ControllerHelpers

  it 'renders the form' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    transaction = Transaction.create(user:, category:, amount: 100, name: 'Sample Note')
    transaction.save
    assign(:category, category)
    assign(:transactions, [transaction])
    @transaction = transaction # Assign @transaction correctly
    render
    expect(rendered).to have_selector('form') do |form|
      expect(form).to have_selector('label[for="transaction_name"]', text: 'Name')
      expect(form).to have_selector('input#transaction_name[type="text"]')

      expect(form).to have_selector('label[for="transaction_amount"]', text: 'Amount')
      expect(form).to have_selector('input#transaction_amount[type="text"]')

      expect(form).to have_selector('input[type="submit"][value="Create Transaction"]')
    end
  end

  it 'displays the "Back" link' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    transaction = Transaction.create(user:, category:, amount: 100, name: 'Sample Note')
    transaction.save
    assign(:category, category)
    assign(:transactions, [transaction])
    @category = category # Assign @category correctly
    @transaction = transaction # Assign @transaction correctly
    render
    expect(rendered).to have_link('Back', href: category_transactions_path(category_id: @category.id))
  end
end
