class CreateReceiptItems < ActiveRecord::Migration[6.0]
  def change
    create_table :receipt_items do |t|
      t.belongs_to :receipt
      t.belongs_to :item
      t.timestamps
    end
  end
end
