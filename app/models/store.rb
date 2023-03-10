class Store < ApplicationRecord
  has_many :receipts
  has_many :store_assignments, dependent: :destroy
  has_many :users, through: :store_assignments
  has_many :carts, through: :store_assignments
  has_many :categories, dependent: :destroy
  has_many :items, through: :categories
  validates :name, presence: true
  
end