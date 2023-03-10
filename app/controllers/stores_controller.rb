class StoresController < ApplicationController
  before_action :set_store, only: [:edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  before_action :require_user, only: [:index, :show]

  def index
    @stores = current_user.stores

  end

  def show
    if current_user.admin?
      redirect_to root_path
    else
      @store = Store.find(params[:id])
      @categories = @store.categories
      @store_assignment = StoreAssignment.where(store_id: @store.id, user_id: current_user.id)
      @cart = current_user.carts.find_by(store_assignment: @store_assignment)
    end
  end

  def new
    @store = Store.new
    @users = User.where(admin: false)
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      flash[:notice] = "Store was successfully created"
      redirect_to root_path
    else
      @users = User.where(admin: false)
      render 'new'
    end
  end

  def edit
    @category = Category.new
    @categories = @store.categories
    @users = User.where(admin: false)
  end

  def update
    if @store.update(store_params)
      flash[:success] = "Store updated successfully"
      redirect_to root_path
    else
      @store.reload
      @category = Category.new
      @categories = @store.categories
      @users = User.where(admin: false)
      render 'edit'
    end
  end
  

  def destroy
    @store.destroy
    flash[:alert] = "Store and all asociated categories and items within them were deleted."
    redirect_to root_path
  end

  def orders
    @orders = @store.receipts
    render 'orders'
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, category_ids: [], user_ids: [])
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end

  def require_user
    unless current_user && !current_user.admin?
      redirect_to root_path
    end
  end


end