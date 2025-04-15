class Api::SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
        body = JSON.parse(request.raw_post)
        puts "Parsed JSON Body: #{body.inspect}"
      
        email = body["email"]
        password = body["password"]
      
        user = User.find_by(email: email)
      
        if user && user.valid_password?(password)
          user.update(auth_token: SecureRandom.hex(10)) if user.auth_token.blank?
          render json: { token: user.auth_token, name: user.name }, status: :ok
        else
          render json: { error: "Invalid credentials" }, status: :unauthorized
        end
      end
      


  end
  