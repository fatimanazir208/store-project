class Item < ApplicationRecord
  has_many :receipt_items
  has_many :receipts, through: :receipt_items
  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :category_id}
  validates :price, presence: true
end