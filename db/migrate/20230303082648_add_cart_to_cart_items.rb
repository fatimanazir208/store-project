class AddCartToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :cart_items, :cart, index: true
  end
end
