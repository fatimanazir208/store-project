class UpdateReceipts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :receipts, :store, index: true
    remove_reference :receipts, :user, index: true
    remove_column :receipts, :total, :int
    add_column :receipts, :order_summary, :text
  end
end
