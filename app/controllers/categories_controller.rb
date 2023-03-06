class CategoriesController < ApplicationController
  def add_to_cart 
  end
  
  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
    @store = Store.find(params[:store_id])
  end

  def edit
    @category = Category.find(params[:id])
    @store = @category.store
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully."
      redirect_to store_path(@category.store)
    else
      @store = Category.find(params[:id]).store
      render 'edit'
    end

  end

  def create
    @category = Category.new(category_params)
    @category.store_id = params[:id]
    @store = Store.find(params[:id])
    if @category.save
      flash[:notice] = "Category was added successfully"
      redirect_to edit_store_path(@category.store)
    else
      @store_errors = nil
      render 'stores/edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:alert] = "Category and all asociated items within them were deleted."
    redirect_to store_path(@category.store)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end


end