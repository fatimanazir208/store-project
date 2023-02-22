class Category < ApplicationRecord
  belongs_to :store
  has_many :items, dependent: :destroy
  validates :name, presence: true
end