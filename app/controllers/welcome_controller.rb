class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if current_user
      if current_user.admin 
        @users = User.all
        @stores = Store.all
        render 'home_admin'
      else
        @user = current_user
        redirect_to "/users/#{@user.id}"
      end
    end
  end

  def orders
    @orders = Receipt.all
  end

end
