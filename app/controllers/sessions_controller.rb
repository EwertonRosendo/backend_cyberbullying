class SessionsController < ApplicationController
  before_action :set_user, only: %i[ create ]
  def create
    if @user&.authenticate(user_params[:password])
      render json: { message: "Logged in successfully", user: @user }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    # You can handle logout here (e.g., clear token or session)
    render json: { message: "Logged out" }
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_digest, :photo, :kind)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(email: user_params[:email])
    end
end
