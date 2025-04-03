class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    redirect_to login_path, alert: "You must be logged in to continue." unless logged_in?
  end

  def current_order
    if logged_in?
      order = Order.find_by(user_id: current_user.id, status: 'pending')
      order ||= Order.create(user: current_user, status: 'pending')
      order
    end
  end
  
  helper_method :current_order  
end
