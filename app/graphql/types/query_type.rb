module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :my_stores, [Types::StoreType], null: false

    def my_stores
      current_user.stores
    end

    field :stores, [Types::StoreType], null: false

    def stores
      Stores.all
    end

    field :store, Types::StoreType, null: false do
      argument :id, ID, required: true
    end

    def store(id:)
      Store.find(id)
    end

    field :category, Types::CategoryType, null: false do
      argument :id, ID, required: true
    end

    def category(id:)
      Category.find(id)
    end

    field :cart, Types::CartType, null: false do
      argument :id, ID, required: true
    end

    def cart(id:)
      Cart.find(id)
    end

    field :receipt, Types::ReceiptType, null: false do
      argument :id, ID, required: true
    end

    def receipt(id:)
      Receipt.find(id)
    end

    field :items, [Types::ItemType], null: false do 
      argument :store_id, ID, required: true
    end

    def items(store_id:)
      store = Store.find_by(id: store_id)
      items = store.items 
      items
    end



  end
end
