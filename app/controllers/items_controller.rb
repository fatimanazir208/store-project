class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @category = Category.find(params[:category_id])
  end


  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.category_id = params[:category_id]
    if @item.save
      flash[:notice] = "Item was added successfully"
      redirect_to category_path(@item.category)
    else
      @category = Category.find(params[:category_id])
      render 'new'
    end
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :price)
  end

end
