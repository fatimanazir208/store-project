# frozen_string_literal: true

module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :store_assignment_id, Integer
    field :total, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :users, [Types::UserType], null: true
    field :cart_items, [Types::CartItemType], null: true
    field :store, Types::StoreType, null: false
  end
end
