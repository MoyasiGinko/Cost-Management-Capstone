require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :view do
  include Devise::Test::ControllerHelpers

  before do
    @user = User.create(name: 'foodie', email: 'f@example.com', password: '123456', password_confirmation: '123456')
    allow(view).to receive(:current_user).and_return(@user)
    assign(:categories, []) # You can assign categories here as needed
    render
  end

  it 'displays the "Add a New Category" link' do
    expect(rendered).to have_link('Add a New Category', href: new_category_path)
  end
end
