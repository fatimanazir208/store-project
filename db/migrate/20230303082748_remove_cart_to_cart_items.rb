class RemoveCartToCartItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :cart_items, :cart
  end
end
