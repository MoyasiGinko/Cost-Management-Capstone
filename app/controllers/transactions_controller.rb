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
    @category = @transaction.category
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @category = @transaction.category
    if @transaction.destroy
      redirect_to category_transactions_path(@category), notice: 'Transaction was successfully deleted.'
    else
      redirect_to category_transactions_path(@category), alert: 'Failed to delete transaction.'
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to category_transactions_path(@transaction.category), notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :category_id)
  end
end
