class RemoveItemFromReceipts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :receipts, :item, index: true
  end
end
