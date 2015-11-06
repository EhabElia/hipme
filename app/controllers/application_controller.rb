class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  # accepts :
  # sign_in (Devise::SessionsController#create) - Permits only the authentication keys (like email)
  # sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
  # account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname
    devise_parameter_sanitizer.for(:account_update) << :firstname << :lastname << :street << :city << :zip << :country << :picture
  end

  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end
end
