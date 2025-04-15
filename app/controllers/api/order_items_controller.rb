class Api::OrderItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_api_user
  
    respond_to :json
  
    def create
      begin
        data = JSON.parse(request.raw_post)
      rescue JSON::ParserError
        return render json: { error: "Invalid JSON" }, status: :bad_request
      end
  
      menu_item_id = data["menu_item_id"]
      quantity = data["quantity"] || 1
  
      item = MenuItem.find_by(id: menu_item_id)
      return render json: { error: "Invalid item" }, status: :not_found unless item
  
      order = current_user.orders.where(status: 'pending').first_or_create
      order_item = order.order_items.create(menu_item: item, quantity: quantity)
  
      if order_item.persisted?
        render json: order_item, status: :created
      else
        render json: { error: order_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
        order = current_user.orders.where(status: 'pending').first
        unless order
          return render json: { error: "No active order" }, status: :not_found
        end
      
        item = order.order_items.find_by(id: params[:id])
        if item
          item.destroy
          render json: { message: "Deleted" }
        else
          render json: { error: "Item not found in current cart" }, status: :not_found
        end
      end
      
      
  
    private
  
    def authenticate_api_user
      token = request.headers["Authorization"]
      @current_user = User.find_by(auth_token: token)
      render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
    end
  
    def current_user
      @current_user
    end
  end
  