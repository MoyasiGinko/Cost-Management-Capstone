require 'rails_helper'

RSpec.describe 'transactions/index.html.erb', type: :view do
  include Devise::Test::ControllerHelpers

  it 'displays the "New Transaction" link' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    assign(:category, category)
    assign(:transactions, []) # You can assign transactions here as needed
    render
    expect(rendered).to have_link('New Transaction', href: new_category_transaction_path(category_id: category.id))
  end

  it 'displays the "Back" link' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    assign(:category, category)
    assign(:transactions, []) # You can assign transactions here as needed
    render
    expect(rendered).to have_link('Back to Categories', href: categories_path)
  end

  it 'displays the "Modify" link' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    transaction = Transaction.create(user:, category:, amount: 100, name: 'Sample Note')
    transaction.save
    assign(:category, category)
    assign(:transactions, [transaction]) # You can assign transactions here as needed
    render
    expect(rendered).to have_link('Modify', href: category_transaction_path(transaction.category, transaction))
  end

  it 'displays the "Delete" link' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.create(user:, name: 'Sample Category', icon: 'https://picsum.photos/200')
    category.save
    transaction = Transaction.create(user:, category:, amount: 100, name: 'Sample Note')
    transaction.save
    assign(:category, category)
    assign(:transactions, [transaction]) # You can assign transactions here as needed
    render

    # Check if the delete form exists for the transaction
    expect(rendered).to have_selector(
      "form[action='#{category_transaction_path(transaction.category, transaction)}'][method='post']", count: 1
    )
    expect(rendered).to have_button('Delete')
  end
end
