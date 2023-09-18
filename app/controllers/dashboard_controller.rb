# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user! # Ensures only authenticated users can access the dashboard

  def index
    # Add logic here to retrieve and display data related to the user
    @user = current_user
    # You can fetch data from your database or any other source
  end
end
