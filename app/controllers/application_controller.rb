class ApplicationController < ActionController::Base
  # Require login for all pages except Devise pages
  before_action :authenticate_user!, unless: :devise_controller?

   # Permit extra fields for Devise forms
  before_action :configure_permitted_parameters, if: :devise_controller?

  # accessible to devise controllers but not directly exposed a a public route
  protected

  def configure_permitted_parameters
    # To allow these extra fields when users sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address , :admin])

    # To allow these extra fields when users update their account
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address])
  end
end
