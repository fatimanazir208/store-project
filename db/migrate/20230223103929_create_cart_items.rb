class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart
      t.belongs_to :item
      t.integer :quantity
      t.timestamps
    end
  end
end
