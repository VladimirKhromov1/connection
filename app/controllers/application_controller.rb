class ApplicationController < ActionController::Base
  before_action :configure_devise, if: :devise_controller?

  private

  def configure_devise
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :age, :first_name, :last_name, :username, :avatar)}

    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :password, :age, :first_name, :last_name, :username, :avatar, :current_password])
  end
end
