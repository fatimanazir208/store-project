class ReceiptsController < ApplicationController

  before_action :require_admin, only: [:index]
  before_action :require_user, except: [:index]

  def index
    @receipts = Receipt.all
  end


  def new
    @cart = Cart.find(params[:cart])
    receipt_creator = ReceiptGeneratorService.new(@cart)
    @receipt = receipt_creator.create_receipt
    redirect_to receipt_path(@receipt)
  end
  
  def show
    @receipt = Receipt.find(params[:id]) 
  end

  private

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end

  def require_user
    unless current_user && !current_user.admin?
      redirect_to root_path
    end
  end

end
