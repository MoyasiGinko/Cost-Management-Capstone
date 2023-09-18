class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id]) if params[:category_id].present?
    @transactions = @category ? @category.transactions : Transaction.all
  end

  def new
    @category = Category.find(params[:category_id]) if params[:category_id].present?
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @category = Category.find(params[:category_id])
    @transaction = @category.transactions.build(transaction_params.merge(user: current_user))
    if @transaction.save
      redirect_to category_transactions_path(@category), notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :category_id)
  end
end
