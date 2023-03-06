class AddCheckoutToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :checkout, :boolean, default: false
  end
end
