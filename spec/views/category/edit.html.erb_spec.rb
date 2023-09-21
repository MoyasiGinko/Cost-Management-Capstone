# spec/features/category_edit_spec.rb

require 'rails_helper'

RSpec.feature 'Category Edit Page' do
  scenario 'Visiting the category edit page' do
    # Create necessary data for the category
    user = create_user(name: 'John Doe', email: 'example@bd.com', password: '123456')
    category = create_category(name: 'Expense Category', icon: 'https://picsum.photos/200', user:)

    # Sign in the user before visiting the page
    sign_in user

    visit edit_category_path(category)

    expect(page).to have_content('Edit Category')
    expect(page).to have_field('Name', with: category.name)
    expect(page).to have_field('Icon', with: category.icon)
    expect(page).to have_button('Update Category')
    expect(page).to have_link('Back', href: category_path(category))
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
    click_button 'Next'
  end
end
