class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  before_action :authenticate_user!
  before_action :authorize_admin, only: [:update]
  before_action :require_admin


  def new
    super
  end

  def create
    super
  end

  def sign_up(users, user)
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:user][:id])
  
  # # Check if current user is authorized to update the user record
  # authorize @user
  # Update the user record with the new data
  if @user.update_attributes(user_params)
    flash[:success] = "User updated successfully."
    redirect_to root_path
  else
    render 'edit'
  end
  end

  #DELETE /resource
  def destroy
    @user = User.find(params[:user_id])
    @user.destroy
    flash[:notice] = "User was deleted successfully"
    redirect_to root_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :first_name, :last_name, :password, :password_confirmation, :admin, store_ids: [])}
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :first_name, :last_name, :password, :password_confirmation, :current_password, store_ids: [])}
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, store_ids: [])
   end


  def authorize_admin
    return unless current_user&.admin?
    user = current_user
    if user && !user.admin?
      flash[:alert] = "You are not authorized to update this user."
      redirect_to root_path
    end
  end

  def update_resource(resource, params)
    if params[:password].blank?
      resource.update_without_password(params.except(:current_password))
    else
      resource.update_with_password(params)
    end
  end

  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path, alert: "You don't have permission to access this page."
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end



end
