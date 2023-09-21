# spec/views/categories/new.html.erb_spec.rb

require 'rails_helper'

RSpec.describe 'categories/new', type: :view do
  before(:each) do
    assign(:category, Category.new)
  end

  it 'renders the form' do
    render
    expect(rendered).to have_selector('form') do |form|
      expect(form).to have_selector('label[for="category_name"]', text: 'Name')
      expect(form).to have_selector('input#category_name[type="text"]')

      expect(form).to have_selector('label[for="category_icon"]', text: 'Icon')
      expect(form).to have_selector('input#category_icon[type="url"]')

      expect(form).to have_selector('input[type="submit"][value="Create Category"]')
    end
  end

  it 'renders the form with the category object' do
    user = User.create(name: 'test', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    category = Category.new(user:, name: 'Sample Category', icon: 'sample-icon-url')
    assign(:category, category)

    render

    expect(rendered).to have_selector('input#category_name[type="text"][value="Sample Category"]')
    expect(rendered).to have_selector('input#category_icon[type="url"][value="sample-icon-url"]')
  end
end
