class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
    @categories = @store.categories
  end

  def new
    @store = Store.new
  end


  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      flash[:notice] = "Store was updated successfully."
      redirect_to stores_path
    else
        render 'edit'
    end

  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:notice] = "Store was successfully created"
      redirect_to 
    else
      render 'new'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:alert] = "Store and all asociated categories and items within them were deleted."
    redirect_to stores_path
  end

  private
  def store_params
    params.require(:store).permit(:name)
  end


end