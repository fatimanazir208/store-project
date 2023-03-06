class AddCartIdToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :cart, :belongs_to
  end
end
