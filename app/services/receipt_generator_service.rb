class ReceiptGeneratorService
  def initialize(cart)
    @cart = cart
  end

  def create_receipt
    receipt = Receipt.new(
      user: @cart.user,
      store: @cart.store,
      order_summary: build_order_summary
    )
    receipt.save!
    @cart.destroy
    receipt
  end

  private

  def build_order_summary
    items = @cart.cart_items.includes(:item)
    summary = "#{@cart.user.full_name} bought"
    items.each do |cart_item|
      summary += " #{cart_item.item.name} x#{cart_item.quantity},"
    end
    summary += " from #{@cart.store.name}"
    summary
  end
end