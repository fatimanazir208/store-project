module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"

    def test_field
      "Hello World"
    end

    field :sign_in, Types::LoginType, null: false do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    field :sign_out, Boolean, null: false

    def sign_in(email:, password:)
      unless email || password
        error = "Provide email or password"
      end

      user = User.find_by_email(email)
      
      unless user
        error = "Invlaid email" 
      end
      
      if user.valid_password?(password)
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{ user.id }")
        session[:token] = token
      else
        error = "Invlaid password"
      end

      {
      user: error ? nil : user,
      token: error ? nil : token,
      error: error
      }
    end

    def sign_out
      session.delete(:token)
      true
    end

    field :get_or_create_cart, Types::CartType, null: false do 
      argument :store_id, Integer, required: true
    end

    def get_or_create_cart(store_id:)
      store_assignment = StoreAssignment.find_by(store_id: store_id, user_id: current_user.id)
      cart = Cart.find_or_create_by(store_assignment: store_assignment)
      store = Store.find_by(id: store_id)
      cart
    end

    field :update_or_create_cart_item, Types::CartItemType, null: false do 
      argument :cart_id, Integer, required: true
      argument :item_id, Integer, required: true
    end

    def update_or_create_cart_item(cart_id:, item_id:)
      cart_item = CartItem.find_or_initialize_by(cart_id: cart_id, item_id: item_id)
      cart_item.quantity += 1
      cart_item.save
      item_price = Item.find_by(id: item_id).price
      cart = Cart.find_by(id: cart_id)
      cart.update(total: cart.total+(item_price))
      cart_item
    end

    field :increment_cart_item, Types::CartItemType, null: false do 
      argument :cart_id, Integer, required: true
      argument :item_id, Integer, required: true
    end

    def increment_cart_item(cart_id:, item_id:)
      cart_item = CartItem.find_by(cart_id: cart_id, item_id: item_id)
      cart_item.quantity += 1
      cart_item.save
      item_price = Item.find_by(id: item_id).price
      cart = Cart.find_by(id: cart_id)
      cart.update(total: cart.total+(item_price))
      cart_item
    end

    field :decrement_cart_item, Types::CartItemType, null: false do 
      argument :cart_id, Integer, required: true
      argument :item_id, Integer, required: true
    end

    def decrement_cart_item(cart_id:, item_id:)
      cart_item = CartItem.find_by(cart_id: cart_id, item_id: item_id)
      cart_item.quantity -= 1
      if cart_item.quantity <= 0
        cart_item.destroy
      else
        cart_item.save
      end
      
      item_price = Item.find_by(id: item_id).price
      cart = Cart.find_by(id: cart_id)
      cart.update(total: cart.total-(item_price))
      cart_item
    end

    field :delete_cart_item, Boolean, null: false do 
      argument :cart_id, Integer, required: true
      argument :item_id, Integer, required: true
    end

    def delete_cart_item(cart_id:, item_id:)
      cart_item = CartItem.find_by(cart_id: cart_id, item_id: item_id)
      cart = Cart.find_by(id: cart_id)
      item_price = Item.find_by(id: item_id).price
      cart.update(total: cart.total - (item_price * cart_item.quantity))
      cart_item.destroy
      true
    end

    field :delete_all_cart_items, Boolean, null: false do 
      argument :cart_id, Integer, required: true
    end

    def delete_all_cart_items(cart_id:)
      cart = Cart.find_by(id: cart_id)
      cart.cart_items.destroy_all
      cart.update(total: 0)
      true
    end

    field :create_receipt, Types::ReceiptType, null: false do 
      argument :store_id, Integer, required: true
    end

    def create_receipt(store_id:)
      store_assignment = StoreAssignment.find_by(store_id: store_id, user_id: current_user.id)
      cart = Cart.find_by(store_assignment: store_assignment)
      receipt = Receipt.new(
        user: cart.user,
        store: cart.store,
        order_summary: build_order_summary(cart)
      )
      receipt.save!
      cart.cart_items.destroy_all
      cart.update(total: 0)
      receipt
    end

    def build_order_summary(cart)
      items = cart.cart_items.includes(:item)
      summary = "#{cart.user.full_name} bought"
      items.each do |cart_item|
        summary += " #{cart_item.item.name} x#{cart_item.quantity},"
      end
      summary += " from #{cart.store.name}"
      summary
    end
  

  end
end
