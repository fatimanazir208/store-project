# frozen_string_literal: true

module Types
  class ReceiptType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :order_summary, String
    field :store_id, Integer
    field :user_id, Integer
  end
end
