class RemoveStoreidAndUseridFromCarts < ActiveRecord::Migration[6.0]
  def change
    remove_column :carts, :store_id
    remove_column :carts, :user_id
  end
end
