class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recent_transactions = Transaction.where(user: @user).order(created_at: :desc).limit(5)
  end
end
