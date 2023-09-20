class CategoriesController < ApplicationController
  #   before_action :authenticate_user!

  def index
    @categories = Category.includes(:transactions).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @transactions = @category.transactions
  end

  def destroy
    @transactions = Transaction.where(category_id: params[:id])
    @transactions.each(&:destroy)
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, notice: 'Category was successfully deleted.'
    else
      redirect_to categories_path, alert: 'Failed to delete category.'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path(@category), notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
