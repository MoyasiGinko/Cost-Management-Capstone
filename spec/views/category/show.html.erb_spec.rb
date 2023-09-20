# spec/features/category_show_spec.rb

require 'rails_helper'

RSpec.feature 'Category Show Page' do
  include ActionView::Helpers::NumberHelper
  scenario 'Visiting the category show page' do
    # Create necessary data for the category
    user = create_user(name: 'John Doe', email: 'example@bd.com', password: '123456')
    category = create_category(name: 'Expense Category', icon: 'https://picsum.photos/200', user:)

    # Sign in the user before visiting the page
    sign_in user

    visit category_path(category)

    expect(page).to have_content('Category Details')
    expect(page).to have_content(category.name.to_s)
    expect(page).to have_css("img[src*='#{category.icon}'][width='100'][height='100']")
    expect(page).to have_content("Total: #{number_to_currency(category.transactions.sum(:amount))}")
    expect(page).to have_link('Edit', href: edit_category_path(category))
    expect(page).to have_button('Delete')
    expect(page).to have_link('View Transactions', href: category_transactions_path(category))
    expect(page).to have_link('Back to Categories', href: categories_path)
  end

  def create_user(name:, email:, password:)
    User.create(name:, email:, password:, password_confirmation: password)
  end

  def create_category(name:, icon:, user:)
    Category.create(name:, icon:, user:)
  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
