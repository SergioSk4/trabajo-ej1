class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  respond_to? :json

    def login
      render json: {"nombre": "Sergio", "Apellido": "Sajche"}
    end
    
end