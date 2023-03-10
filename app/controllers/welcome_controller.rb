class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if user_signed_in?
      if current_user.admin? 
      @users = User.all
      @stores = Store.all
      render 'home_admin'
      else
        redirect_to stores_path
      end
    end
  end

  

end
