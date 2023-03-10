class CartHandlerService
  def initialize(cart)
    @cart = cart
  end

  def add_item(item)
    cart_item = CartItem.find_or_initialize_by(cart_id: @cart.id, item_id: item.id)
    cart_item.quantity += 1
    cart_item.save
    update_cart_total(item.price)
  end

  def increment_item(item)
    cart_item = CartItem.find_by(cart_id: @cart.id, item_id: item.id)
    cart_item.quantity += 1
    cart_item.save
    update_cart_total(item.price)
  end


  def decrement_item(item)
    cart_item = CartItem.find_by(cart_id: @cart.id, item_id: item.id)
    cart_item.quantity -= 1
    if cart_item.quantity <= 0
      cart_item.destroy
    else
      cart_item.save
    end
    update_cart_total(item.price)
  end

  def remove_item(item)
    cart_item = CartItem.find_by(cart_id: @cart.id, item_id: item.id)
    @cart.update(total: @cart.total - (item.price * cart_item.quantity))
    cart_item.destroy
  end

  def clear_cart
    @cart.cart_items.destroy
    update_cart_total(0)
  end

  private

  def update_cart_total(price)
    @cart.update(total: @cart.cart_items.sum(:quantity) * price)
  end
end
