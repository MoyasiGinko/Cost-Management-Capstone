class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:transactions).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

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


  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
