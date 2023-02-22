class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if current_user
      if current_user.admin 
        render 'home_admin'
      else
        @user = current_user
        redirect_to "/users/stores/#{@user.id}"
      end
    end
  end
end
