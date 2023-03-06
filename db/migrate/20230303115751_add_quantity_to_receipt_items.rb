class AddQuantityToReceiptItems < ActiveRecord::Migration[6.0]
  def change
    add_column :receipt_items, :quantity, :int
  end
end
