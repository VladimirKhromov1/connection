class ApplicationController < ActionController::Base
  before_action :configure_devise, if: :devise_controller?

  private

  def configure_devise
    devise_parameter_sanitizer.permit(:account_update, keys: [ :email, :password, :first_name, :last_name, :username, :avatar ])
  end
end
