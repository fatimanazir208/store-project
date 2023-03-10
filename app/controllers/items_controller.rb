class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :require_admin

  def new
    @item = Item.new
    @category = Category.find(params[:category])
  end


  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Item was updated successfully."
      redirect_to new_item_path(category: @item.category)
    else
      render 'edit'
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Item was added successfully"
      redirect_to new_item_path(category: @item.category)
    else
      @category = Category.find(params[:item][:category_id])
      render 'new'
    end
  end


  def destroy
    @item.destroy
    flash[:alert] = "#{@item.name} were deleted successfully."
    redirect_to new_item_path(category: @item.category)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :category_id)
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end

end
