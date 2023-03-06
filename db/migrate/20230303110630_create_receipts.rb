class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.belongs_to :item
      t.belongs_to :store_assignment
      t.timestamps
    end
  end
end
