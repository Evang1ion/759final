# app/controllers/api/menu_items_controller.rb
class Api::MenuItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :force_json_format
  
    def show
      item = MenuItem.find_by(id: params[:id])
  
      if item
        render json: {
          id: item.id,
          name: item.name,
          description: item.description,
          price: item.price.to_f,
          restaurant_id: item.restaurant_id
        }, status: :ok
      else
        render json: { error: "Menu item not found" }, status: :not_found
      end
    end
  
    private
  
    def force_json_format
      request.format = :json
    end
  end
  