class RemoveStoreAssignmentAddUserStoreToReceipts < ActiveRecord::Migration[6.0]
  def change
    remove_reference :receipts, :store_assignment, index: true
    add_reference :receipts, :store, index: true
    add_reference :receipts, :user, index: true
  end
end
