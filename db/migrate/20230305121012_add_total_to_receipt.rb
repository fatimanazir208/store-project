class AddTotalToReceipt < ActiveRecord::Migration[6.0]
  def change
    add_column :receipts, :total, :int
  end
end
