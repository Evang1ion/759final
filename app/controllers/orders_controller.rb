class OrdersController < ApplicationController
  before_action :authenticate_user!  

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
end
