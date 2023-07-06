# frozen_string_literal: true

module Types
  class StoreType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :users, [Types::UserType], null: true
    field :categories, [Types::CategoryType], null: true
  end
end
