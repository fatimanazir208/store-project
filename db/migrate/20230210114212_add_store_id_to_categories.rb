class AddStoreIdToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :store_id, :int
  end
end
