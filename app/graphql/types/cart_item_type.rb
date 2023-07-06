# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :item_id, Integer
    field :quantity, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :cart_id, Integer
    field :item, ItemType, null: false
  end
end



