class RemoveRatingFromStores < ActiveRecord::Migration[6.0]
  def change
    remove_column :stores, :rating, :decimal
  end
end
