class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #預設方法
  before_action :authenticate_user!

  #Devise客製化屬性說明https://github.com/plataformatec/devise#strong-parameters
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
