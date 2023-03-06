class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was added successfully"
      @user.store_assignments.each do|user_store|
        @cart = Cart.new 
        @cart.store_assignment = user_store
        @cart.save
      end
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully."
      @user.store_assignments.each do|user_store|
        @cart = Cart.new 
        @cart.store_assignment = user_store
        @cart.save
      end
      redirect_to root_path
    else
      render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "User was deleted successfully"
    redirect_to root_path
  end

  def orders
    @user = User.find(params[:user])
    @orders = @user.receipts
    render 'orders'
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :admin, store_ids: [])
  end


end