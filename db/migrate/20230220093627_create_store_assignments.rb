class CreateStoreAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :store_assignments do |t|
      t.belongs_to :user
      t.belongs_to :store
      t.timestamps
    end
  end
end
