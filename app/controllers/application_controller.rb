class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found_method
     if request.referrer.nil?  
          render file: Rails.public_path.join('404.html'), status: :not_found, layout: false 
     else
          redirect_to request.referrer
     end
end



  protected

     def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:admin, :first_name, :last_name)}
          devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:admin, :first_name, :last_name)}
     end

end
