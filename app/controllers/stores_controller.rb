class StoresController < ApplicationController
  def index
    if current_user.admin
      @stores = Store.all
    else
      @stores = current_user.stores
    end
  end

  def show
    @store = Store.find(params[:store])
    @categories = @store.categories
    if !current_user.admin
      @store_assignment = StoreAssignment.where(store_id: @store.id, user_id: current_user.id).first
      @cart = Cart.where(store_assignment_id: @store_assignment.id).first
    end
  end

  def new
    @store = Store.new
    @category = Category.new
    @users = User.where(admin: false)
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:notice] = "Store was successfully created"
      @store.store_assignments.each do|user_store|
        @cart = Cart.new 
        @cart.store_assignment = user_store
        @cart.save
      end
      redirect_to root_path
    else
      render 'new'
    end
  end


  def edit
    @store = Store.find(params[:id])
    @category = Category.new
  end

  def update
    @store = Store.find(params[:id])
    if !@store.categories.empty?
      categories = @store.categories.collect(&:id)
      categories = categories - (params[:store][:category_ids]).map!(&:to_i)
    end
    if @store.update(params.require(:store).permit(:name, :category_ids))
      if !@store.categories.empty?
        categories.each do |category_id|
          @category = Category.find(category_id)
          @category.destroy
        end
      end
      flash[:notice] = "Store was updated successfully."
      redirect_to root_path
    else
      @store_errors = @store.errors.full_messages
      @store = Store.find(params[:id])
      @category = Category.new
      render 'edit'
    end
  end

  

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:alert] = "Store and all asociated categories and items within them were deleted."
    redirect_to root_path
  end

  def orders
    @store = Store.find(params[:store])
    @orders = @store.receipts
    render 'orders'
  end

  private
  def store_params
    params.require(:store).permit(:name, user_ids: [])
  end


end