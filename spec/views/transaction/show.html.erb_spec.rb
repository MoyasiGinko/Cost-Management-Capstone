# spec/features/transaction_show_spec.rb

require 'rails_helper'

RSpec.feature 'Transaction Show Page' do
  include ActionView::Helpers::NumberHelper # Include the NumberHelper module
  scenario 'Visiting the transaction show page' do
    # Create necessary data for the transaction
    user = create_user(name: 'John Doe', email: 'example@bd.com', password: '123456')
    category = create_category(name: 'Expense Category', icon: 'https://picsum.photos/200', user:)
    transaction = create_transaction(name: 'Expense', amount: 50.0, category:)

    # Sign in the user before visiting the page
    sign_in user

    visit category_transaction_path(category, transaction)

    expect(page).to have_content('Transaction Details')
    expect(page).to have_content("Name: #{transaction.name}")
    expect(page).to have_content("Amount: #{number_to_currency(transaction.amount)}")
    expect(page).to have_content("Category: #{category.name}")

    # Check for edit and back links if needed
    expect(page).to have_link('Edit', href: edit_category_transaction_path(category, transaction))
    expect(page).to have_link('Back to Transactions', href: category_transactions_path(category))
  end

  def create_user(name:, email:, password:)
    User.create(name:, email:, password:, password_confirmation: password)
  end

  def create_category(name:, icon:, user:)
    Category.create(name:, icon:, user:)
  end

  def create_transaction(name:, amount:, category:)
    Transaction.create(name:, amount:, category:, user: category.user) # Set the user for the transaction
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
