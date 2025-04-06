class SessionsController < ApplicationController
  def create
    if user&.authenticate(params[:password])
      render json: { message: "Logged in successfully", user: user }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    # You can handle logout here (e.g., clear token or session)
    render json: { message: "Logged out" }
  end
end
