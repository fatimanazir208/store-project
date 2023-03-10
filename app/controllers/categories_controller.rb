class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :require_admin

  def edit
    @store = @category.store
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully."
      redirect_to store_path(@category.store)
    else
      @store = Category.find(params[:id]).store
      render 'edit'
    end

  end

  def create
    @store = Store.find(params[:category][:store_id])
    @category = @store.categories.build(category_params)
    if @category.save
      flash[:success] = "Category created successfully"
      redirect_to edit_store_path(@store)
    else
      @users = User.where(admin: false)
      render template: 'stores/edit'
    end

  end

  def destroy
    @category.destroy
    flash[:alert] = "Category and all asociated items within them were deleted."
    redirect_to store_path(@category.store)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :store_id)
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end

end