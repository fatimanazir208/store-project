class ChangePriceToBeIntegerInItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :price, :int
  end
end
