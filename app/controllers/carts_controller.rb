class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def add_to_cart
    @item = Item.find(params[:item])
    @cart = Cart.find(params[:cart])
    @cartItem = CartItem.where(cart_id: @cart.id, item_id: @item.id).first
    if @cartItem == nil
      @cartItem = CartItem.new
      @cartItem.cart_id = params[:cart]
      @cartItem.item_id = params[:item]
      @cartItem.quantity = 0
      @cartItem.save
    end
    @cartItem.quantity = @cartItem.quantity + 1
    @cartItem.save
    @cart.total = @cart.total + @item.price
    @cart.save
    respond_to do |format|
      format.js { render partial: 'carts/cart'}
    end

  end

  def remove_from_cart
    @item = Item.find(params[:item])
    @cart = Cart.find(params[:cart])
    @cartItem = CartItem.where(cart_id: @cart.id, item_id: @item.id).first
    @cartItem.quantity = @cartItem.quantity - 1
    @cartItem.save
    @cart.total = @cart.total - @item.price
    @cart.save
    if @cartItem.quantity == 0
      remove_item_from_cart
    else
      respond_to do |format|
        format.js { render partial: 'carts/cart'}
      end
    end
  end

  def empty_cart
    @cart = Cart.find(params[:cart])
    @cart.cart_items.destroy_all
    @cart.total = 0
    @cart.save
    respond_to do |format|
      format.js { render partial: 'carts/cart'}
    end
  end


  def remove_item_from_cart
    @item = Item.find(params[:item])
    @cart = Cart.find(params[:cart])
    @cartItem = CartItem.where(cart_id: @cart.id, item_id: @item.id).first
    @cart.total = @cart.total - (@item.price * @cartItem.quantity)
    @cart.save
    @cartItem.destroy
    respond_to do |format|
      format.js { render partial: 'carts/cart'}
    end
  end

 
  

end