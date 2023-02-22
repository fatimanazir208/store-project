class RemoveImagePathFromStore < ActiveRecord::Migration[6.0]
  def change
    remove_column :stores, :img_path, :string
  end
end
