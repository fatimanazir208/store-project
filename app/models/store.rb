class Store < ApplicationRecord
  has_many :store_assignments
  has_many :users, through: :store_assignments
  has_many :categories, dependent: :destroy
  has_many :items, through: :categories
  validates :name, presence: true
  
end