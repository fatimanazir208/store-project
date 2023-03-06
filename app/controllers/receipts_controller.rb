class ReceiptsController < ApplicationController
  def generate_receipt
    @cart = Cart.find(params[:cart])
    @receipt = Receipt.new
    @receipt.order_summary = "#{current_user.full_name} bought"
    @cart.cart_items.each do |cart_item|
      @receipt.order_summary << " #{cart_item.item.name} x#{cart_item.quantity},"
    end
    @receipt.order_summary << " from #{@cart.store.name}"
    @receipt.user = current_user
    @receipt.store = @cart.store
    @receipt.save
    @cart.cart_items.destroy_all
    @cart.total = 0
    @cart.save
    redirect_to checkout_path(receipt: @receipt)
  end

  def checkout
    @receipt = Receipt.find(params[:receipt]) 
  end
end
