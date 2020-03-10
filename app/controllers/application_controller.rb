class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configre_permitted_parameters, if: :devise_controller?

  def configre_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:email,:password])
  end
  def after_sign_out_path_for(resource)
    root_path # サインアウト後のリダイレクト先URL
  end
end
