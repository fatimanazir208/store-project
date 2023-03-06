class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.belongs_to :store_assignment
      t.integer :total
      t.timestamps
    end
  end
end
