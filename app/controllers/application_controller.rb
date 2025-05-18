class ApplicationController < ActionController::Base
  before_action :validade_token
  skip_before_action :verify_authenticity_token
  
  def validade_token
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      decoded = SessionsHelper.decode(token)
      if not decoded
        render json: { error: "Invalid Token" }, status: :unauthorized
      end
    end
end
