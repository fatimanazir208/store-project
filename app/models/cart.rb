class Cart < ApplicationRecord
  belongs_to :store_assignment
  has_one :user, through: :store_assignment
  has_one :store, through: :store_assignment
  has_many :cart_items
  has_many :items, through: :cart_items
end