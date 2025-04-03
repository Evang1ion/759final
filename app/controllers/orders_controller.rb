class OrdersController < ApplicationController
  before_action :require_login

  def new
    @order = Order.new
    @menu_items = MenuItem.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      redirect_to @order, notice: 'Order has been filled'
    else
      render :new
    end
  end

  def show
    @order = current_order
  
    if @order.nil? || @order.order_items.empty?
      redirect_to restaurants_path, alert: "Your cart is empty. Please add items from the menu."
    end
  end
  

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
