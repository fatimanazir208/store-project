class AddTotalToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :total, :int
  end
end
