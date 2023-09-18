# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # Root route for authenticated users
  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end

  # Root route for non-authenticated users (welcome page)
  unauthenticated do
    root to: 'welcome#index', as: :unauthenticated_root
  end

  # Remove the following line as it's redundant
  root 'welcome#index'
end
