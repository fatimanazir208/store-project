class StoreAssignment < ApplicationRecord
  has_one :cart, dependent: :destroy
  belongs_to :user
  belongs_to :store
end