# spec/features/welcome_spec.rb

require 'rails_helper'

RSpec.feature 'Welcome page' do
  scenario 'Visiting the welcome page' do
    visit root_path

    expect(page).to have_content('Welcome to Cost Management')
    expect(page).to have_content('Your solution for managing expenses and transactions.')

    # Check for the "Get Started" button
    # expect(page).to have_link('Get Started', href: '/')

    # Check for the "Sign In" and "Sign Up" buttons
    expect(page).to have_link('Sign In', href: new_user_session_path)
    expect(page).to have_link('Sign Up', href: new_user_registration_path)
  end
end
