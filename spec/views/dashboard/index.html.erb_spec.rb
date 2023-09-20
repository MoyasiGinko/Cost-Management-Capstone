# spec/features/dashboard_spec.rb

require 'rails_helper'

RSpec.feature 'Dashboard page' do
  scenario 'Visiting the dashboard page when signed in' do
    # Create a user and sign them in
    user = create_user(name: 'John Doe') # Replace with your user creation method
    sign_in_user(user) # Replace with your sign-in method

    visit root_path

    expect(page).to have_content('Welcome to Your Dashboard')
    expect(page).to have_content("Hello, #{user.name}!")

    # Add more content checks as needed
  end

  def create_user(name:, email: 'john@example.com', password: 'password')
    User.create(name:, email:, password:, password_confirmation: password)
  end

  def sign_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password' # Assuming the password is 'password'
    click_button 'Log in'
  end
end
