class UsersController < ApplicationController
  before_action :require_admin

  def orders
    @user = User.find(params[:user])
    @orders = @user.receipts
    render 'orders'
  end

  private

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end


end