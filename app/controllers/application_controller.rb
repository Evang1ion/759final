class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  before_action :set_current_order

  helper_method :current_order

  def current_order
    @current_order
  end

  private

  def set_current_order
    if user_signed_in?
      @current_order = current_user.orders.where(status: 'pending').first_or_create
    else
      @current_order = nil
    end
  end
end
