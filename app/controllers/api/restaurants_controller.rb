class Api::RestaurantsController < ApplicationController
    def menu_items
      restaurant = Restaurant.find_by(id: params[:id])
      if restaurant
        render json: restaurant.menu_items, status: :ok
      else
        render json: { error: "Restaurant not found" }, status: :not_found
      end
    end
  end
  