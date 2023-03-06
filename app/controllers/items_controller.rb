class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @category = Category.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
    @category = @item.category
  end

  def update
    @item = Item.find(params[:id])
    @category = @item.category
    if @item.update(item_params)
      flash[:notice] = "Item was updated successfully."
      redirect_to "/new_item/#{@category.id}"
    else
      render 'edit'
    end
  end



  def create
    @item = Item.new(item_params)
    @item.category_id = params[:id]
    @category = Category.find(params[:id])
    if @item.save
      flash[:notice] = "Item was added successfully"
      redirect_to "/new_item/#{@category.id}"
    else
      @category = Category.find(params[:id])
      render 'new'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:alert] = "#{@item.name} were deleted successfully."
    redirect_to "/new_item/#{@item.category.id}"
  end

  private
  def item_params
    params.require(:item).permit(:name, :price)
  end

end
