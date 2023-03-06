class AddStoreAssignmentsToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :store_assignment_id, :int
  end
end
