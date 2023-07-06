class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
# before_action :configure_permitted_parameters, if: :devise_controller?

#   def not_found_method
#      if request.referrer.nil?  
#           render file: Rails.public_path.join('404.html'), status: :not_found, layout: false 
#      else
#           redirect_to request.referrer
#      end
# end

  def current_user
    if mobile_app_token.present?
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.decrypt_and_verify mobile_app_token
      user_id = token.gsub('user-id:', '').to_i
      User.find user_id
    else
      return unless session[:token]
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.decrypt_and_verify session[:token]
      user_id = token.gsub('user-id:', '').to_i
      User.find user_id
    end
  end

  def mobile_app_token
    @mobile_app_token ||= begin
      token = request.headers["mobile-app-token"]
      return nil if token.blank? || token == "null" || token == "undefined"
      token
    end
  end

#   protected

#      def configure_permitted_parameters
#           devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:admin, :first_name, :last_name)}
#           devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:admin, :first_name, :last_name)}
#      end

end
