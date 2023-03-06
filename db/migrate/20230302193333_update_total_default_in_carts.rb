class UpdateTotalDefaultInCarts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :carts, :total, from: nil, to: 0
  end
end
