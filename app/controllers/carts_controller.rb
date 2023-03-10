class CartsController < ApplicationController
  before_action :set_cart, except: [:add_to_cart]
  before_action :require_user

  def add_to_cart
    @store_assignment = StoreAssignment.find_by(store_id: params[:store], user_id: current_user.id)
    @cart = Cart.find_or_create_by(store_assignment: @store_assignment)
    @item = Item.find(params[:item])
    cart_handler.add_item(@item)
    respond_with_cart_partial
  end

  def increment_item_to
    @item = Item.find(params[:item])
    cart_handler.increment_item(@item)
    respond_with_cart_partial
  end

  def decrement_item_from
    @item = Item.find(params[:item])
    cart_handler.decrement_item(@item)
    respond_with_cart_partial
  end

  def remove_item_from
    @item = Item.find(params[:item])
    cart_handler.remove_item(@item)
    respond_with_cart_partial
  end

  def empty
    cart_handler.clear_cart
    respond_with_cart_partial
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_handler
    @cart_handler ||= CartHandlerService.new(@cart)
  end

  def respond_with_cart_partial
    respond_to do |format|
      format.js { render partial: 'carts/cart'}
    end
  end

  def require_user
    unless current_user && !current_user.admin?
      redirect_to root_path
    end
  end
end
