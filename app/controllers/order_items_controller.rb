class OrderItemsController < ApplicationController
  before_action :require_login

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    order_item = current_order.order_items.find_or_initialize_by(menu_item: menu_item)
    order_item.quantity ||= 0
    order_item.quantity += 1
    order_item.save

    redirect_to restaurant_menu_items_path(menu_item.restaurant), notice: 'Item added to your order.'
  end

  def destroy
    order_item = current_order.order_items.find(params[:id])
    order_item.destroy
    redirect_to order_path(current_order), notice: 'Item removed from order.'
  end
end
