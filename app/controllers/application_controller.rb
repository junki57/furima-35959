class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :encrypted_password, :first_name, :family_name, :first_name_kana, :family_name_kana, :birthday])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :encrypted_password])
  end
end
