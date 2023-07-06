# frozen_string_literal: true

module Types
  class LoginType < Types::BaseObject
    field :user, UserType, null: true
    field :token, String, null: true
    field :error, String, null: true
  end
end
